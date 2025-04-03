# NPU/DSP

# NPU firmware signing
ifeq ($(SEC_BUILD_OPTION_KNOX_CSB),true)
type=${VBMETA_TYPE}
project=${SEC_BUILD_CONF_MODEL_SIGNING_NAME}
SECURE_SCRIPT=../buildscript/tools/signclient.jar

UNSIGNED_NPU := device/samsung/erd8845/firmware/npu/unsigned_AIE.bin
SIGNED_NPU := device/samsung/erd8845/firmware/npu/AIE.bin
NPU_RENAMING := $(shell mv $(SIGNED_NPU) $(UNSIGNED_NPU))
NPU_SIGNNING := $(shell java -jar $(SECURE_SCRIPT) -runtype ${type} -model ${project} -input $(UNSIGNED_NPU) -output $(SIGNED_NPU))
endif

PRODUCT_COPY_FILES += \
    device/samsung/erd8845/firmware/npu/AIE.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/AIE.bin
