#mkdir /mnt/fat
#mount /dev/sda1 /mnt/fat
#cd /mnt/fat
#dd if=/dev/zero of=/mnt/fat/fsimage bs=1M count=1500
#mkfs.ext4 -F -q /mnt/fat/fsimage
#mount -t ext4 -o loop /mnt/fat/fsimage /mnt/custom

