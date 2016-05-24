# ==========================================================
# LUAINC contains the following header files:
# ==========================================================
# -rw-rw-r-- 1 aaron aaron  6006 May 18 01:16 lauxlib.h
# -rw-rw-r-- 1 aaron aaron  4762 May 18 01:16 luaconf.h
# -rw-rw-r-- 1 aaron aaron 11964 May 18 01:16 lua.h
# -rw-rw-r-- 1 aaron aaron  1113 May 18 01:16 lualib.h
# ==========================================================
# LUALIB contains the following luajit library(ies):
# ==========================================================
# ==========================================================
# FIXME: Assumes armeabi-v7a shared library will be installed
# ==========================================================
##== LUASEC ==
LOCAL_PATH 		:= $(call my-dir)
LUAROOT			:= /data/local/tmp/lib/lua/5.1
LUAETC			:= /data/local/tmp/etc
LUALIB			:= /data/local/tmp/lib
LUAINC			:= /data/local/tmp/lib/include /data/local/tmp/lib/luajit-2.0

include 		$(CLEAR_VARS)
LOCAL_MODULE    	:= libssl
LOCAL_MODULE_FILENAME 	:= libssl
LOCAL_SRC_FILES 	:= $(LUALIB)/libssl.so
include 		$(PREBUILT_SHARED_LIBRARY)

include 		$(CLEAR_VARS)
LOCAL_MODULE    	:= libcrypto
LOCAL_MODULE_FILENAME 	:= libcrypto
LOCAL_SRC_FILES 	:= $(LUALIB)/libcrypto.so
include 		$(PREBUILT_SHARED_LIBRARY)

include 		$(CLEAR_VARS)
LOCAL_MODULE    	:= libluasocket
LOCAL_MODULE_FILENAME 	:= libluasocket
LOCAL_SRC_FILES 	:= $(LUALIB)/libluasocket.so
include 		$(PREBUILT_SHARED_LIBRARY)

include 		$(CLEAR_VARS)
LOCAL_ARM_MODE 		:= arm   
LOCAL_MODULE		:= luassl
LOCAL_SRC_FILES 	:= ssl.c 
LOCAL_C_INCLUDES	+= $(LOCAL_PATH) $(LOCAL_PATH)/../lua $(LUAINC)
LOCAL_LDLIBS		:= -O2 -shared -fpic $(LUALIB)/libluajit.so
LOCAL_CFLAGS 		:= -pedantic -Wall -O2 -fpic
LOCAL_SHARED_LIBRARIES	:= ssl crypto luasocket luajit x509 context
include 		$(BUILD_SHARED_LIBRARY)


include 		$(CLEAR_VARS)
LOCAL_ARM_MODE 		:= arm   
LOCAL_MODULE		:= context
LOCAL_SRC_FILES 	:= context.c 
LOCAL_C_INCLUDES	+= $(LOCAL_PATH) $(LOCAL_PATH)/../lua $(LUAINC)
LOCAL_LDLIBS		:= -O2 -shared -fpic $(LUALIB)/libluajit.so
LOCAL_CFLAGS 		:= -pedantic -Wall -O2 -fpic
LOCAL_SHARED_LIBRARIES	:= ssl crypto luasocket luajit
include 		$(BUILD_SHARED_LIBRARY)

include 		$(CLEAR_VARS)
LOCAL_ARM_MODE 		:= arm   
LOCAL_MODULE		:= x509
LOCAL_SRC_FILES 	:= x509.c 
LOCAL_C_INCLUDES	+= $(LOCAL_PATH) $(LOCAL_PATH)/../lua $(LUAINC)
LOCAL_LDLIBS		:= -O2 -shared -fpic $(LUALIB)/libluajit.so
LOCAL_CFLAGS 		:= -pedantic -Wall -O2 -fpic
LOCAL_SHARED_LIBRARIES	:= ssl crypto luasocket luajit
include 		$(BUILD_SHARED_LIBRARY)

all:
	-mkdir /data
	-mkdir /data/local
	-mkdir /data/local/tmp
	-mkdir /data/local/tmp/lib
	-mkdir /data/local/tmp/lib/lua
	-mkdir $(LUAROOT)
	-mkdir $(LUAROOT)/ssl
	cp ssl.lua $(LUAROOT)
	cp https.lua $(LUAROOT)/ssl
	cp ../libs/armeabi-v7a/libluassl.so $(LUAROOT)/ssl/core.so
	cp ../libs/armeabi-v7a/libcontext.so $(LUAROOT)/ssl/context.so
	cp ../libs/armeabi-v7a/libx509.so $(LUAROOT)/ssl/x509.so
