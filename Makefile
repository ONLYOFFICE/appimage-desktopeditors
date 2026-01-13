OUT_DIR:=out/
APP_DIR:=desktopeditors/
ARCH:=$(shell uname -m)
TARGET:=$(OUT_DIR)DesktopEditors-$(ARCH).AppImage
P2A:=pkg2appimage
export STATIC_FILES=$(PWD)

.PHONY : all clean

all: $(TARGET)

clean:
	rm -fr $(OUT_DIR) $(APP_DIR) $(P2A)

$(TARGET): $(P2A)

$(P2A):
	wget https://raw.githubusercontent.com/AppImage/AppImages/master/$@
	chmod a+x $@

$(OUT_DIR)%.AppImage: %.yml
	./$(P2A) $<
