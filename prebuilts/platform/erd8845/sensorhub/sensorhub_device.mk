# Sensor Hub HAL
ifneq ($(filter a55x%, $(TARGET_PRODUCT)),)
SHUB_FIRMWARE_NAME := a55x
endif

PRODUCT_PACKAGES += \
	android.hardware.sensors-service.multihal \
	libsensorndkbridge

PRODUCT_PACKAGES += \
	sensors.sensorhub \
	sensors.inputvirtual

PRODUCT_COPY_FILES += \
	device/samsung/erd8845/sensorhub/init.sensorhub.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.sensorhub.rc

PRODUCT_COPY_FILES += \
	device/samsung/erd8845/firmware/sensorhub/shub_rose_$(SHUB_FIRMWARE_NAME).bin:$(TARGET_COPY_OUT_VENDOR)/firmware/os.checked.bin