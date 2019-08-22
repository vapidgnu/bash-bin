#!/bin/bash
# author: dotc
# email: oqopo@protonmail.com
# hosted: vapidgnu
#### "WARNING! THIS SCRIPTY IS TIPSY"
echo "WARNING! THIS SCRIPTY IS TIPSY"
test -d $1 || echo "${1} not a directory."

echo "Press [Enter] to continue! ^c to quit"
read
cd /home/dotc/sandbox/usr/src || echo $?

unlink linux > /dev/null 2>&1 || \
        test ! -e linux || \
         rm -vrI linux || \
        echo "can't cope with linux"

ln -s $1 linux || echo $?
zcat /proc/config.gz > linux/.config
zcat /proc/config.gz > linux/config-current
cd
echo /usr/bin/genkernel --makeopts="-j8" \
        --kernel-config=/home/dotc/sandbox/usr/src/linux/config-current \
        --oldconfig \
        --microcode \
        all

echo grub-mkconfig -o /boot/grub/grub.cfg


