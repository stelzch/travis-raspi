#!/bin/sh

OSDIR=raspbian_lite
wget https://downloads.raspberrypi.org/raspbian_lite/2016-11-29-16:33/root.tar.xz \
    -O $OSDIR.tar.xz
mkdir $OSDIR
tar xJf $OSDIR.tar.xz -C $OSDIR
cp /usr/bin/qemu-arm-static $OSDIR/usr/bin
echo "export PATH=/bin:/sbin:/usr/bin:/usr/sbin" >> $OSDIR/root/.bashrc
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register
mount --bind /sys $OSDIR/sys
mount --bind /dev $OSDIR/dev
mount --bind /dev/pts $OSDIR/dev/pts
mount --bind /proc $OSDIR/proc
chroot $OSDIR /usr/bin/apt update
umount $OSDIR/dev/pts
umount $OSDIR/sys
umount $OSDIR/proc
umount $OSDIR/dev

