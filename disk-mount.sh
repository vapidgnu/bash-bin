

mountpoint /mnt/gentoo > /dev/null || mount /dev/sda4  /mnt/gentoo
mountpoint /mnt/gentoo/home > /dev/null || mount /dev/sda5 /mnt/gentoo/home
mountpoint /mnt/gentoo/boot > /dev/null || mount /dev/sda1 /mnt/gentoo/boot
mountpoint /mnt/gentoo/boot/efi > /dev/null || mount /dev/sda2 /mnt/gentoo/boot/efi
swapon 


