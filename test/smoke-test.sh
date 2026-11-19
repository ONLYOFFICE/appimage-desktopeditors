#!/bin/bash
# Smoke test of the DesktopEditors AppImage inside a distro container.
#
# Expects:  /app/app.AppImage (ro), /result (rw)
# Env:      MODE=extract (default, APPIMAGE_EXTRACT_AND_RUN) | fuse (needs --device /dev/fuse --cap-add SYS_ADMIN)
#
# Steps: install common desktop libraries -> check for unresolved libs ->
#        start the app as a regular user under Xvfb with a sample .docx ->
#        check that the process is alive and the editor window exists -> screenshot.
# Exit code: 0 = PASS, 1 = FAIL.

set -u
R=/result
mkdir -p $R
export LANG=C.UTF-8 LC_ALL=C.UTF-8
log() { echo "[$(date +%T)] $*" | tee -a $R/summary.txt; }

. /etc/os-release
log "OS: $PRETTY_NAME ($(uname -m)), mode: ${MODE:-extract}"

# Libraries a typical desktop system has; the AppImage relies on them
# (see excludelist). libSM/libICE are needed by Qt xcb platform plugin.
install_pkgs() {
  if command -v apt-get >/dev/null; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -qq
    # install one by one: some names differ between releases (t64 transition)
    for p in xvfb x11-utils imagemagick procps fuse3 \
             libgtk-3-0 libgtk-3-0t64 libnss3 libgl1 libegl1 libgbm1 libasound2 libasound2t64 \
             libxkbcommon-x11-0 libx11-xcb1 libxcb-shape0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
             libxcb-randr0 libxcb-render-util0 libxcb-xinerama0 libxcb-xkb1 libxcb-cursor0 \
             libsm6 libice6 libxss1 libxtst6 libcups2 libcups2t64 libdbus-1-3 fonts-dejavu-core; do
      apt-get install -y -qq --no-install-recommends $p || true
    done
  elif command -v dnf >/dev/null; then
    dnf install -y -q xorg-x11-server-Xvfb xwininfo ImageMagick procps-ng fuse3 gtk3 nss mesa-libGL mesa-libEGL \
      mesa-libgbm alsa-lib libxkbcommon-x11 xcb-util-wm xcb-util-image xcb-util-keysyms xcb-util-renderutil \
      xcb-util-cursor libSM libICE libXScrnSaver libXtst cups-libs dbus-libs dejavu-sans-fonts findutils
  elif command -v zypper >/dev/null; then
    zypper -n --gpg-auto-import-keys in xorg-x11-server-Xvfb xwininfo ImageMagick procps fuse3 libgtk-3-0 \
      mozilla-nss Mesa-libGL1 Mesa-libEGL1 libgbm1 libasound2 libxkbcommon-x11-0 libxcb-icccm4 libxcb-image0 \
      libxcb-keysyms1 libxcb-render-util0 libxcb-cursor0 libSM6 libICE6 libXss1 libXtst6 libcups2 libdbus-1-3 \
      dejavu-fonts findutils
  elif command -v pacman >/dev/null; then
    pacman -Syu --noconfirm --needed xorg-server-xvfb xorg-xwininfo imagemagick procps-ng fuse3 gtk3 nss mesa \
      libglvnd alsa-lib libxkbcommon-x11 xcb-util-wm xcb-util-image xcb-util-keysyms xcb-util-renderutil \
      xcb-util-cursor libsm libice libxss libxtst libcups ttf-dejavu
  fi
}
log "installing desktop libraries"
install_pkgs > $R/packages.log 2>&1

id tester >/dev/null 2>&1 || useradd -m tester
H=/home/tester
cp /app/app.AppImage $H/app.AppImage
chmod 755 $H/app.AppImage
chown tester $H/app.AppImage
as_tester() { su tester -s /bin/bash -c "cd ~ && $*"; }

# 1. Unresolved libraries (main binaries and Qt platform plugin)
as_tester "APPIMAGE_EXTRACT_AND_RUN=1 ./app.AppImage --appimage-extract >/dev/null 2>&1"
D=$H/squashfs-root
if [ ! -d $D/usr/bin ]; then log "FAIL: --appimage-extract failed"; exit 1; fi
: > $R/missing-libs.txt
for b in usr/bin/DesktopEditors usr/bin/editors_helper usr/bin/converter/x2t usr/bin/platforms/libqxcb.so usr/bin/libQt5XcbQpa.so.5; do
  [ -f $D/$b ] || continue
  LD_LIBRARY_PATH=$D/usr/bin:$D/usr/bin/converter:$D/usr/lib ldd $D/$b 2>/dev/null \
    | awk -v f=$b '/not found/{print f": "$1}' >> $R/missing-libs.txt
done
MISSING=$(awk '{print $2}' $R/missing-libs.txt | sort -u | tr '\n' ' ')
log "missing libraries: ${MISSING:-none}"

# 2. Launch under Xvfb with a sample document
SAMPLE=$(find $D/usr/bin/converter/empty -name new.docx | head -1)
cp "$SAMPLE" $H/sample.docx
chown tester $H/sample.docx
rm -rf $D   # launch from the AppImage itself, not from the extracted copy

Xvfb :99 -screen 0 1366x768x24 >/dev/null 2>&1 &
sleep 2
ENVS="APPIMAGE_EXTRACT_AND_RUN=1"
[ "${MODE:-extract}" = fuse ] && ENVS=""
as_tester "DISPLAY=:99 $ENVS nohup ./app.AppImage ~/sample.docx > ~/app.log 2>&1 &"

WIN=""
for i in $(seq 1 24); do
  sleep 5
  WIN=$(DISPLAY=:99 xwininfo -root -tree 2>/dev/null | grep -oE '"[^"]*(sample\.docx|ONLYOFFICE)[^"]*"' | sort -u | tr '\n' ' ')
  [ -n "$WIN" ] && break
done
sleep 10   # let the editor render and make sure it does not crash right after start
pgrep -u tester -f DesktopEditors >/dev/null && ALIVE=yes || ALIVE=no
log "process alive: $ALIVE"
log "windows: ${WIN:-none}"
DISPLAY=:99 import -window root $R/screenshot.png 2>/dev/null
cp $H/app.log $R/app.log 2>/dev/null
pkill -u tester 2>/dev/null

if [ "$ALIVE" = yes ] && [ -n "$WIN" ]; then
  log "RESULT: PASS"
  exit 0
fi
log "RESULT: FAIL"
echo "--- app.log (tail):"; tail -n 30 $R/app.log 2>/dev/null
exit 1
