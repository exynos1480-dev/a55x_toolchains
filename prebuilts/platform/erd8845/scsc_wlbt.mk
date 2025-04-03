# Copy WLBT fw and other related files from vendor/samsung_slsi/mx140/firmware/
ifeq ($(TARGET_PRODUCT),full_erd8845_t_mz)
$(call inherit-product-if-exists, vendor/samsung_slsi/mx140/firmware_mz/wlbt_firmware.mk)
else
$(call inherit-product-if-exists, vendor/samsung_slsi/mx140/firmware/wlbt_firmware.mk)
endif

# PRODUCT_PACKAGES for vendor/samsung_slsi/scsc_tools/dev_tools/
$(call inherit-product-if-exists, vendor/samsung_slsi/scsc_tools/dev_tools/dev_tools.mk)

# PRODUCT_PACKAGES for vendor/samsung_slsi/scsc_tools/wifi-bt/
#$(call inherit-product-if-exists, vendor/samsung_slsi/scsc_tools/wifi-bt/wifi-bt.mk)

# PRODUCT_PACKAGES for vendor/samsung_slsi/scsc_tools/test_engine
#$(call inherit-product-if-exists, vendor/samsung_slsi/scsc_tools/test_engine/test_engine.mk)

# PRODUCT_PACKAGES for vendor/samsung_slsi/scsc_tool/kic
#$(call inherit-product-if-exists, vendor/samsung_slsi/scsc_tools/kic/kic.mk)

# PRODUCT_PROPDUCT_PROPERTIES for fwsnoop
PRODUCT_PRODUCT_PROPERTIES += \
        persist.bluetooth.fwsnoop_supported=true
