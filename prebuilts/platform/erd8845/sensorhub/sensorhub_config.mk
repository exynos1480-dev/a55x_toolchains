ifneq ($(filter a55x%, $(TARGET_PRODUCT)),)
SHUB_FIRMWARE_NAME := a55x
endif

# firmware signing
ifeq ($(SEC_BUILD_OPTION_KNOX_CSB),true)
type=${VBMETA_TYPE}
project=${SEC_BUILD_CONF_MODEL_SIGNING_NAME}
SECURE_SCRIPT=../buildscript/tools/signclient.jar

UNSIGN_SENSORHUB := device/samsung/$(TARGET_BOARD_PLATFORM)/firmware/sensorhub/shub_rose_$(SHUB_FIRMWARE_NAME)_unchecked.bin
SIGN_SENSORHUB := device/samsung/$(TARGET_BOARD_PLATFORM)/firmware/sensorhub/shub_rose_$(SHUB_FIRMWARE_NAME).bin
RENAMING_SENSORHUB := $(shell mv $(SIGN_SENSORHUB) $(UNSIGN_SENSORHUB))
SIGNNING_SENSORHUB := $(shell java -jar $(SECURE_SCRIPT) -runtype ${type} -model ${project} -input $(UNSIGN_SENSORHUB) -output $(SIGN_SENSORHUB))
endif

SENSOR_HAL := SENSOR_HUB
SENSOR_MCU := LSI

USE_SENSOR_MULTI_HAL := true
SENSOR_INPUT_VIRTUAL_HAL := true