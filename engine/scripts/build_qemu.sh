mkdir build
cd build
../configure --target-list="aarch64-softmmu,microblaze-softmmu" --disable-docs --disable-xen --disable-alsa --disable-pa --disable-kvm --enable-gcrypt