OUT_DIR:=out/
APP_DIR:=desktopeditors/
TARGET:=$(OUT_DIR)DesktopEditors-x86_64.AppImage
TARGET_TEST:=$(OUT_DIR)DesktopEditors-testing-x86_64.AppImage
P2A:=pkg2appimage
export STATIC_FILES=$(PWD)

.PHONY : all testing clean

all: $(TARGET)

testing: $(TARGET_TEST)

clean:
	rm -fr $(OUT_DIR) $(APP_DIR) $(P2A)

$(TARGET) $(TARGET_TEST): $(P2A)

$(TARGET_TEST): export DESKTOPEDITORS_DEB_PATH = $(abspath $(wildcard ../desktop-apps/win-linux/package/linux/deb/*.deb))

$(P2A):
	wget https://raw.githubusercontent.com/AppImage/AppImages/master/$@
	chmod a+x $@

$(OUT_DIR)%.AppImage: %.yml
	./$(P2A) $<
