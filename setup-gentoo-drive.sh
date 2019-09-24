#!/bin/bash

CHROOT="/mnt/gentoo"

e () {
        echo $@
}


IS_MOUNTED () {
        for M in $@; do
                mountpoint $M &> /dev/null
        done
}

MOUNT_CHROOT_ENV () {
        cd $CHROOT
        cp /etc/resolv.conf etc
        mount -t proc none proc
        mount --rbind /sys sys
        mount --make-rslave sys
        mount --rbind /dev dev
        mount --make-rslave dev
        mount ${BOOT} boot
	test ! -d boot/efi && mkdir boot/efi
        mount ${UEFI} boot/efi
        swapon ${SWAP}
        cd -
}

while :; do
        echo
        read -erp "Generic (g) or Manual (m) [g/m] " -n 1 MODE
        if [[ $MODE = "g" ]]; then
                read -erp "Select drive for generic partition scheme: " -i \
                        "/dev/sda" DRIVE
                TARGET=${DRIVE}
        elif [[ $MODE = "m" ]]; then
                read -erp "Select drive to run cgdisk: " -i \
                        "/dev/sda" DRIVE
                TARGET=${DRIVE}
                cgdisk ${TARGET}
                e "finish mounting FS manually"
                e "then return to the script"
                e "hopefully, if it's mount . ..."
                exit 0
        else
                echo "Invalid option"
        fi
        #DRIVE=${DRIVE#*/dev/}
        #TARGET=${TARGET#*/dev}
        read -erp "Partioning: $MODE
Drive: ${DRIVE}
Target: ${DRIVE}
Is this corrent [y/n] " -n 1 yn
        if [[ $yn == "y" ]]; then
                break
        fi
done

if [[ $MODE = "g" ]]; then
        echo "WARNING! ALL DATA WILL BE LOST ON"
        echo "Target drive: ${TARGET}. Press Enter to continue"
        # Would be better to just cat gdisk.spec | gdisk ${TARGET}
        read # don't fuckup the following format
        echo "
o
y
n
1

+128M

n
2

+64M
EF00
n
3

+1024M
8200
n
4



w
y
p


" | gdisk $TARGET
        if [[ $? != 0 ]]; then
                echo "failed to partition: ${TARGET}"
                exit 2
        else
                BOOT=${TARGET}1; ROOTFS=${TARGET}4; SWAP=${TARGET}3; UEFI=${TARGET}2
                mkfs.ext4 ${BOOT} 1> /dev/null || exit $?
                mkfs.ext4 ${ROOTFS} 1> /dev/null || exit $?
                mkswap ${SWAP} 1> /dev/null || exit $?
                mkfs.vfat -F 32 ${UEFI} 1> /dev/null || exit $?
        fi

fi

test -d $CHROOT || mkdir $CHROOT || exit $?
mount ${ROOTFS} ${CHROOT} || exit $?

cd $CHROOT
#wget latest stage3
builddate=$(wget -O - http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/ | sed -nr "s/.*href=\"stage3-amd64-([0-9].*).tar.xz\">.*/\1/p")
wget http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-$builddate.tar.xz
tar pxf stage3*
rm -f stage3*

IS_MOUNTED sys proc dev boot boot/efi || MOUNT_CHROOT_ENV

test $? != 0 || chroot ${CHROOT} /bin/bash
