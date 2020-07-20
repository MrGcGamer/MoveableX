INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e
TARGET = iphone:clang:11.2:11.2

TWEAK_NAME = MoveableX

MoveableX_FILES = Tweak.xm
MoveableX_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
