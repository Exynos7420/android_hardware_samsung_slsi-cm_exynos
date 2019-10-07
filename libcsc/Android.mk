LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	csc.c

LOCAL_C_INCLUDES := \
	hardware/samsung_slsi-cm/$(TARGET_BOARD_PLATFORM)/include \
	$(LOCAL_PATH)/../include \
	$(LOCAL_PATH)/../libexynosutils

LOCAL_HEADER_LIBRARIES := generated_kernel_headers

LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)

LOCAL_CFLAGS :=

LOCAL_MODULE := libcsc

LOCAL_ARM_MODE := arm

LOCAL_STATIC_LIBRARIES := libswconverter
LOCAL_SHARED_LIBRARIES := liblog libexynosutils

LOCAL_CFLAGS += -DUSE_SAMSUNG_COLORFORMAT

ifeq ($(BOARD_USES_FIMC),true)
LOCAL_CFLAGS += -DENABLE_FIMC
LOCAL_SHARED_LIBRARIES += libexynosfimc
endif
ifeq ($(TARGET_BOARD_PLATFORM),exynos5)
LOCAL_CFLAGS += -DENABLE_GSCALER
LOCAL_SHARED_LIBRARIES += libexynosgscaler
ifeq ($(BOARD_USES_SCALER), true)
LOCAL_CFLAGS += -DENABLE_SCALER
LOCAL_SHARED_LIBRARIES += libexynosscaler
endif
endif

LOCAL_CFLAGS += -DUSE_ION
LOCAL_SHARED_LIBRARIES += libion_exynos

LOCAL_CFLAGS += -Wno-unused-parameter

include $(BUILD_SHARED_LIBRARY)
