# check out the 'android build cookbook' page
# for some good definitions

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
include $(LOCAL_PATH)/Config.mk

LOCAL_MODULE:= libpq
# only heavily used modules should only prelinked
LOCAL_PRELINK_MODULE:= false

LOCAL_ARM_MODE:= arm

LOCAL_REQUIRED_MODULES:= libpgport libssl libcrypto

LOCAL_SHARED_LIBRARIES+= libssl libcrypto
LOCAL_STATIC_LIBRARIES+= libpgport

LOCAL_LDLIBS := -L$(LOCAL_PATH)/../../../../openssl-android/libs/armeabi -lssl -lcrypto

LOCAL_SRC_FILES:= $(SRC_FILES)

LOCAL_CFLAGS:= -I$(LOCAL_PATH)/../../include \
	-I$(LOCAL_PATH)/../../port \
	-DFRONTEND -DSO_MAJOR_VERSION=5 -DUNSAFE_STAT_OK

# need to add openssl/ssl.h openssl/crypto.h because
# they are not 'installed' into the out/ directory

# git clone https://github.com/scottt/openssl-android.git ../../../../openssl-android
LOCAL_CFLAGS+= -I$(LOCAL_PATH)/../../../../openssl-android/include

# TODO: figure out rpath (maybe it's already added?)
LOCAL_LDFLAGS:= -Wl,--version-script=$(LOCAL_PATH)/exports.list

include $(BUILD_SHARED_LIBRARY)
