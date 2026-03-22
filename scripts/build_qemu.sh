#!/bin/bash

# Run this script from desired qemu fork you want to build. cd into that repo and invoke this script. Sit back and relax
mkdir -p build
cd build
../configure --target-list="arm-softmmu,aarch64-softmmu,microblaze-softmmu" --enable-slirp --disable-docs --disable-xen --disable-alsa --disable-pa --disable-kvm --enable-gcrypt
make