#!/bin/bash

HW_DTB_PATH="/home/neo/projects/virtec/xilinx-zcu102-v2025.2-11160223/xilinx-zcu102-2025.2/pre-built/linux/images"
IMAGE_PATH="/home/neo/projects/virtec/xilinx-zcu102-v2025.2-11160223/xilinx-zcu102-2025.2/pre-built/linux/images"
TMP_DIR="/tmp/${USER}/qemu/0"
LOG_FILE_PATH="/home/neo/projects/virtec"

if [ -d "$TMP_DIR" ]; then
    echo "Directory $TMP_DIR exists. Deleting files from previous session..."
    rm /tmp/${USER}/qemu/0/*
else
    echo "Creating $TMP_DIR .."
    mkdir -p /tmp/${USER}/qemu/0
fi

../xilinx-qemu/build/qemu-system-aarch64 -machine arm-generic-fdt \
    -machine-path ${TMP_DIR} \
    -m 2G \
    -nographic \
    -device loader,addr=0xfd1a0104,data=0x8000000e,data-len=4 \
    -serial /dev/pts/1 \
    -hw-dtb ${HW_DTB_PATH}/zynqmp-qemu-multiarch-arm.dtb \
    -device loader,file=${IMAGE_PATH}/zynqmp_fsbl.elf,cpu-num=0 \
    -drive file=${IMAGE_PATH}/qemu_qspi.bin,if=mtd,format=raw,index=0 \
    -boot mode=1 \
    -D ${LOG_FILE_PATH}/qemu_output.log -d in_asm,guest_errors

#qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic -bios u-boot.bin
#-global xlnx,zynqmp-boot.cpu-num=0 \
#-device loader,file=${IMAGE_PATH}/zynqmp_fsbl.elf,addr=0xfffc0000,cpu-num=0 \
