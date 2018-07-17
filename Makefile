OUT_DIR:=out/
TARGET:=$(OUT_DIR)DesktopEditors-x86_64.AppImage
P2A:=pkg2appimage

.PHONY : all

all: $(TARGET)

clean:
	rm -fr $(TARGET)

$(P2A):
	wget https://raw.githubusercontent.com/AppImage/AppImages/master/$@
	chmod a+x $@

$(OUT_DIR)%.AppImage: %.yml
	./$(P2A) $<