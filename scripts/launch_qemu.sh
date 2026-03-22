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


../engine/qemu-official/build/qemu-system-aarch64 \
    -M raspi4b \
    -cpu cortex-a72 \
    -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootdelay=1" \
    -dtb ../../rpi-dtbs/bcm2711-rpi-4-b.dtb \
    -kernel /home/neo/projects/virtec/zephyr_4b.elf \
    -m 2G \
    -serial stdio \
    -usb -device usb-mouse -device usb-kbd \
    -device usb-net,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::5555-:22 \



# ZEPHYR PATH /home/neo/projects/virtec/
# GOLDEN OS IMG -sd /home/neo/Downloads/2020-08-20-raspios-buster-arm64.img \
# GOLDEN KERNEL IMG -kernel /home/neo/projects/virtec/qemu-rpi-kernel/kernel8.img \
# PERIPH CONFIG RPI3B -usb -device usb-mouse -device usb-kbd \
# NETWORK AND VNC CONFIG
# -device usb-net,netdev=net0 \
# -netdev user,id=net0,hostfwd=tcp::5555-:22 \

#-kernel /home/neo/projects/virtec/virtec-monorepo/bsp/linux/arch/arm64/boot/Image \
#-kernel /home/neo/projects/virtec/raspberry-pi-zero-2w/kernel8.img \
#-dtb /home/neo/projects/virtec/rpi-dtbs/bcm2710-rpi-3-b.dtb \
#qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic -bios u-boot.bin
#-global xlnx,zynqmp-boot.cpu-num=0 \w
#-device loader,file=${IMAGE_PATH}/zynqmp_fsbl.elf,addr=0xfffc0000,cpu-num=0 \