TARGET = iphone:clang:latest:6.0
ARCHS = armv7 armv7s
APPLICATION_NAME = MyoActivator
MYO_FRAMEWORK_PATH := MyoKit.embeddedframework

MyoActivator_FILES = Classes/main.m Classes/MyoActivatorAppDelegate.m Classes/MyoSettingsViewController.m
MyoActivator_CFLAGS = -F$(MYO_FRAMEWORK_PATH) -fobjc-arc
MyoActivator_LDFLAGS = -F$(MYO_FRAMEWORK_PATH) -ObjC
MyoActivator_BUNDLE_RESOURCE_DIRS = Resources $(MYO_FRAMEWORK_PATH)/Resources
MyoActivator_FRAMEWORKS = UIKit QuartzCore CoreGraphics CoreBluetooth GLKit MyoKit
MyoActivator_LIBRARIES = activator

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/application.mk
