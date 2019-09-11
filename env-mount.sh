


cd /mnt/gentoo
cp /etc/resolv.conf etc
mount -t proc none proc
mount --rbind /sys sys
mount --make-rslave sys
mount --rbind /dev dev
mount --make-rslave dev
chroot . /bin/bash

