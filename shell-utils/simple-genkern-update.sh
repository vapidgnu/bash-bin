#!/bin/bash
#  vapidgnu
#### "WARNING! THIS SCRIPTY IS TIPSY"
echo "WARNING! THIS SCRIPTY IS TIPSY"
test -d $1  || exit 2
test -d $2 && SRC_DIR=$2 || SRC_DIR="/usr/src"

echo "Press [Enter] to continue! ^c to quit"
read
cd /usr/src > /dev/null 2>&1 || echo $?

unlink linux > /dev/null 2>&1 || \
        test ! -e linux || \
        rm -vrI linux || \
        echo "can't cope with linux"

ln -s $1 linux || echo $?
zcat /proc/config.gz > linux/.config
zcat /proc/config.gz > linux/config-current
cd
/usr/bin/genkernel --makeopts="-j$(nproc)" \
        --kernel-config=/usr/src/linux/config-current \
        --oldconfig \
        --microcode \
        all

#should test if mounted first. 
grub-mkconfig -o /boot/grub/grub.cfg


