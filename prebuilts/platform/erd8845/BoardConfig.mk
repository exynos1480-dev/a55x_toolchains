#
# Copyright (C) 2023 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

TARGET_BOARD_INFO_FILE := device/samsung/erd8845/board-info.txt
TARGET_SOC_NAME := exynos
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# SOC Model specific variable. For CDD12 Requirement
TARGET_SOC_MANUFACTURE := Samsung
TARGET_SOC_MODEL := s5e8845

# Storage options
BOARD_USES_BOOT_STORAGE := ufs
BOARD_USES_VENDORIMAGE := true
TARGET_COPY_OUT_VENDOR := vendor
TARGET_USERIMAGES_USE_F2FS := true
BOARD_FLASH_BLOCK_SIZE := 4096

include device/samsung/erd8845/BootConfig.mk

BOARD_RAMDISK_USE_LZ4 := true

# SELinux Platform Vendor policy for exynos
# VENDOR_SEPOLICY := device/samsung/sepolicy/common \

ifeq (, $(findstring $(VENDOR_SEPOLICY), $(BOARD_VENDOR_SEPOLICY_DIRS)))
BOARD_VENDOR_SEPOLICY_DIRS += $(VENDOR_SEPOLICY)
endif

# SELinux Platform Private policy for exynos
# SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS := device/samsung/sepolicy/private

# SELinux Platform Public policy for exynos
# SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS := device/samsung/sepolicy/public

# SYSTEM SDK
BOARD_SHIPPING_API_LEVEL := 34

#VNDK
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
BOARD_VNDK_VERSION := current

BOARD_USES_METADATA_PARTITION := true
# Extra mount point
BOARD_ROOT_EXTRA_SYMLINKS += /mnt/vendor/efs:/efs
BOARD_ROOT_EXTRA_SYMLINKS += /mnt/vendor/persist:/persist

# Enable Mobicore
BOARD_MOBICORE_ENABLE := false

# Enable GK & KM
BOARD_TEE_GATEKEEPER_ENABLE := true
BOARD_TEE_KEYMINT_ENABLE := true

# CBD (CP booting daemon)
SOONG_CONFIG_NAMESPACES += cbd
SOONG_CONFIG_cbd := version protocol cptype
SOONG_CONFIG_cbd_version := v3
SOONG_CONFIG_cbd_protocol := sipc
SOONG_CONFIG_cbd_cptype := modap

# Modem interface 
ifeq ($(shell secgetspf SEC_PRODUCT_FEATURE_FACTORY_SUPPORT_INTERPOSER), FALSE)
PRODUCT_COPY_FILES += \
	vendor/samsung_slsi/common/cpboot_v3/init.ss310.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.baseband.rc
endif

# Enable AVB2.0
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA4096
BOARD_AVB_KEY_PATH := device/samsung/erd8845/avbkey_rsa4096.pem
BOARD_AVB_ROLLBACK_INDEX := 0
# Chained partition
BOARD_AVB_BOOT_KEY_PATH := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_BOOT_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_BOOT_ROLLBACK_INDEX := 0
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VENDOR_BOOT_KEY_PATH := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_VENDOR_BOOT_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 0
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_DTBO_KEY_PATH := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_DTBO_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_DTBO_ROLLBACK_INDEX := 0
BOARD_AVB_DTBO_ROLLBACK_INDEX_LOCATION := 3

BOARD_AVB_RECOVERY_KEY_PATH := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_RECOVERY_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 0
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 4

BOARD_AVB_INIT_BOOT_KEY_PATH := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_INIT_BOOT_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := 0
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 5

BOARD_AVB_VBMETA_SYSTEM := system vendor system_dlkm
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 0
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 10
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

BOARD_AVB_VBMETA_VENDOR := vendor_dlkm
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := 0
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 11
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

# Metadata encryption
BOARD_USES_METADATA_PARTITION := true

# Modules
BOARD_MODULE_USES_GDC := true
BOARD_MODULE_USES_SENSOR_FRAMEWORK := true

# Skia backend
TARGET_USES_VULKAN := true

# Gralloc implementation
BOARD_USES_EXYNOS_GRALLOC_VERSION := 4
BOARD_GPU_TYPE := sgpu

SOONG_CONFIG_NAMESPACES += sgr
SOONG_CONFIG_sgr := \
        backend \
        enable_sajc \
        product_vendor_version

SOONG_CONFIG_sgr_backend := sgpu
SOONG_CONFIG_sgr_enable_sajc := true
SOONG_CONFIG_sgr_product_vendor_version := true

# Gralloc interface
SOONG_CONFIG_NAMESPACES += exynosgraphicbuffer
SOONG_CONFIG_exynosgraphicbuffer := \
        gralloc_version

SOONG_CONFIG_exynosgraphicbuffer_gralloc_version := four_sgr

# USB (USB gadgethal)
SOONG_CONFIG_NAMESPACES += usbgadgethal
SOONG_CONFIG_usbgadgethal:= exynos_product
SOONG_CONFIG_usbgadgethal_exynos_product := default

TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
TARGET_RO_FILE_SYSTEM_TYPE ?= erofs

# Build a separate vendor_dlkm partition
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := $(TARGET_RO_FILE_SYSTEM_TYPE)
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Build a separate system_dlkm partition
BOARD_USES_SYSTEM_DLKMIMAGE := true
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := $(TARGET_RO_FILE_SYSTEM_TYPE)
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm

TARGET_BOARD_KERNEL_HEADERS := hardware/samsung_slsi/exynos/kernel-6.1-headers/kernel-headers

# SENSOR HUB
#BOARD_USES_EXYNOS_SENSORS_DUMMY := true
BOARD_USES_EXYNOS_SENSORS_HAL := true

# Options for CHUB Firmware build
NANOHUB_SENSORHAL2 := true
NANOHUB_TESTSUITE := true
NANOHUB_TARGET := erd8845 all

ifeq ($(NANOHUB_SENSORHAL2), true)
NANOHUB_PATH := hardware/samsung_slsi/contexthub
else
NANOHUB_PATH := device/google/contexthub
endif

#
# AUDIO & VOICE
#
include device/samsung/audio/erd8845_sec/BoardConfig-audio.mk

########################
# Video Codec
########################
# 0. Default C2
BOARD_USE_DEFAULT_SERVICE := false

# 1. Exynos C2
BOARD_USE_CODEC2_HIDL_1_2 := true
BOARD_USE_CSC_FILTER := true
BOARD_USE_DEC_SW_CSC := false
BOARD_USE_ENC_SW_CSC := false
BOARD_SUPPORT_MFC_ENC_RGB := true
BOARD_USE_BLOB_ALLOCATOR := false
BOARD_USE_PERFORMANCE := true
BOARD_USE_QUERY_HDR2SDR := false
BOARD_USE_COMPRESSED_COLOR := true
BOARD_USE_GDC := false
BOARD_USE_HDR10PLUS_STAT_ENC := true
BOARD_USE_FULL_ST2094_40 := true
ifeq ($(BOARD_USE_FULL_ST2094_40),true)
SOONG_CONFIG_NAMESPACES += exynos_headers_c2
SOONG_CONFIG_exynos_headers_c2 := full_st2094_40
SOONG_CONFIG_exynos_headers_c2_full_st2094_40 := true
endif
ifeq ($(BOARD_USE_DEFAULT_SERVICE), false)
SOONG_CONFIG_NAMESPACES += vendor_c2_service
SOONG_CONFIG_vendor_c2_service := use_c2_api
SOONG_CONFIG_vendor_c2_service_use_c2_api := true
endif
BOARD_SUPPORT_MFC_ENC_BT2020 := true
BOARD_USE_MFC_HEADER := true
ifeq ($(BOARD_USE_MFC_HEADER), true)
SOONG_CONFIG_NAMESPACES += mfc
SOONG_CONFIG_mfc += version
SOONG_CONFIG_mfc_version := v18_10
endif
########################

# Exynos RIL and telephony
# Multi SIM(DSDS)
SIM_COUNT := 2
SUPPORT_MULTI_SIM := true
# Support NR
SUPPORT_NR := true
# Support 5G on both stacks
SUPPORT_NR_DS := true
# Using IRadio 2.1
USE_RADIO_HAL_2_1 := true
# Support DSDS legacy Setting for DS capable for CP
SUPPORT_DS := true
# Support AIDL for SecureElement
SUPPORT_SE_AIDL := true

# Support the vendor telephony such as systemUI_slsi
USE_OEM_RIL_SERVICE := true
USE_TELEPHONY_INJECTION := true
USE_SYSTEMUI_SLSI := true


# DQE xml
BOARD_DQE_VENDOR_XML_PATH := device/samsung/erd8845/dqe
BOARD_DQE_VENDOR_XML_SUBDIR := $(TARGET_PRODUCT:full_%=%)

BOARD_LIBHDR_PLUGIN_MAIN := libhdr_plugin
#BOARD_LIBHDR_PLUGIN_SUB :=
BOARD_LIBHDR_META_PLUGIN := libhdr_meta_plugin_default

SOONG_CONFIG_NAMESPACES += libhdr
ifneq ($(BOARD_LIBHDR_PLUGIN_MAIN),)
SOONG_CONFIG_libhdr := main
SOONG_CONFIG_libhdr_main := $(BOARD_LIBHDR_PLUGIN_MAIN)

ifneq ($(BOARD_LIBHDR_PLUGIN_SUB),)
SOONG_CONFIG_libhdr += sub
SOONG_CONFIG_libhdr_sub := $(BOARD_LIBHDR_PLUGIN_SUB)
endif

ifneq ($(BOARD_LIBHDR_META_PLUGIN),)
SOONG_CONFIG_libhdr += meta_plugin
#SOONG_CONFIG_libhdr_meta_plugin := $(BOARD_LIBHDR_META_PLUGIN)
SOONG_CONFIG_libhdr_meta_plugin := vendor.samsung.libcolor.custom
endif
endif

ifeq ($(BOARD_USES_DISPLAY_COLOR_INTERFACE), true)
TARGET_USES_DISPLAY_RENDER_INTENTS := true
endif

# WLBT (wlbt firmware)
SOONG_CONFIG_NAMESPACES += wlbt
SOONG_CONFIG_wlbt := type
SOONG_CONFIG_wlbt_type := rose_s621p

# WiFi related defines
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_slsi
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_slsi
BOARD_HAS_SAMSUNG_WLAN           := true
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WLAN_DEVICE                := slsi
WIFI_DRIVER_MODULE_ARG           := ""
WLAN_VENDOR                      := 8
SCSC_WLAN_DEVICE_NAME            := rose_s621p
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_FEATURE_AWARE          := true
SLSI_WIFI_HAL_NL_ATTR_CONFIG     := true
WIFI_FEATURE_HOSTAPD_11AX        := true

WIFI_HAL_INTERFACE_COMBINATIONS  := {{{STA}, 1}, {{P2P, NAN}, 1}}
WIFI_HAL_INTERFACE_COMBINATIONS  += , {{{STA}, 1}, {{AP}, 1}}

# Enable BT/WIFI related code changes in Android source files
CONFIG_SAMSUNG_SCSC_WIFIBT       := true
SLSI_WIFI_FEATURE_TAS            := true

#Camera
BOARD_CAMERA_HAL_TARGET := WNC

# GNSS related defines
BOARD_USES_EXYNOS_GNSS_HAL := true
ifeq ($(BOARD_USES_EXYNOS_GNSS_HAL),)
BOARD_USES_EXYNOS_GNSS_DUMMY := true
endif

# RECOVERY TG - VAB
# https://source.android.com/docs/core/architecture/bootloader/partitions/generic-boot#option-1
# Devices launching with Android 12 must set BOARD_USES_RECOVERY_AS_BOOT to empty and use new configurations. If such devices:
# Don't use a dedicated recovery partition, the architecture is as shown in Figure 1 and the device setup option is Option 1.
# Option 1: No dedicated recovery partition
# BOARD CONFIG should be configs below for AB UPDATER
#BOARD_USES_RECOVERY_AS_BOOT :=
#BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
#BOARD_USES_GENERIC_KERNEL_IMAGE := true
#BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE :=
#BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

ifeq ($(AB_OTA_UPDATER), true)
$(warning RECOVERY mode configs for AB_OTA_UPDATER)

# move recovery ramdisk to vendor_boot
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true

# remove /lib/modules in recovery ramdisk
BOARD_RECOVERY_KERNEL_MODULES :=
endif

# <Recovery TG>  #
PRODUCT_COPY_FILES += \
    device/samsung/erd8845/recovery/init.recovery.samsung.rc:root/init.recovery.samsung.rc

TARGET_RECOVERY_FSTAB := device/samsung/common/recovery/recovery.fstab.s5e8845.ab
