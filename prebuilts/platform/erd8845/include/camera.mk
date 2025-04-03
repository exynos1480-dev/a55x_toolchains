include vendor/samsung_slsi/exynos/camera/R24/mcd/Interface/VendorPrebuilt/R24/camera.mk

$(warning #############################################)
$(warning # TARGET_PRODUCT : $(TARGET_PRODUCT))
ifneq ($(filter a55x%, $(TARGET_PRODUCT)),)
$(warning #############################################)
$(warning # TARGET_SOC : $(TARGET_SOC))
PRODUCT_PACKAGES += \
    libuniplugin \
    libdualcam_refocus_video \
    libdualcam_refocus_image \
    liblivefocus_preview_interface \
    liblivefocus_preview_engine \
    liblivefocus_capture_interface \
    liblivefocus_capture_engine \
    libhypermotion_interface \
    libhypermotion_core \
    libvideobeauty_interface \
    libsaiv_BeautySolutionVideo \
    libeis_interface \
    libeis_core \
    lib_supernight_interface \
    libautotracking_interface \
    libbodyid.arcsoft \
    libzoomroi.samsung \
    libai_denoiser_interface \
    libhdraid.gpu.arcsoft \
    libhdraid.npu.arcsoft
endif

# Camera HAL
PRODUCT_PACKAGES += \
    vendor.samsung.hardware.camera.provider-service_64 \
    camera.$(TARGET_SOC)

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \

# Camera
PRODUCT_COPY_FILES += \
    device/samsung/erd8845/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml
