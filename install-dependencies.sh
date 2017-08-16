#!/bin/sh

OSDIR=raspbian_$RASPBIAN_VERSION
wget https://downloads.raspberrypi.org/raspbian_lite/archive/$RASPBIAN_VERSION/root.tar.xz \
    -O $OSDIR.tar.xz
mkdir $OSDIR
tar xJf $OSDIR.tar.xz -C $OSDIR
sudo cp /usr/bin/qemu-arm-static $OSDIR/usr/bin
echo "export PATH=/bin:/sbin:/usr/bin:/usr/sbin" >> $OSDIR/root/.bashrc
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register
sudo mount --bind /sys $OSDIR/sys
sudo mount --bind /dev $OSDIR/dev
sudo mount --bind /dev/pts $OSDIR/dev/pts
sudo mount --bind /proc $OSDIR/proc
sudo chroot $OSDIR /usr/bin/apt update
sudo umount $OSDIR/dev/pts
sudo umount $OSDIR/sys
sudo umount $OSDIR/proc
sudo umount $OSDIR/dev

