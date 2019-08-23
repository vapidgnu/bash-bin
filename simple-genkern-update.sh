#!/bin/bash
#  vapidgnu
# USAGE: simple-genkern-update.sh linux-kernel-X.X.X /usr/src
#### "WARNING! THIS SCRIPTY IS TIPSY"
echo "WARNING! THIS SCRIPTY IS TIPSY"
echo "System must currently have a working"
echo "kernel config located at /proc/config.gz" 

# test user supplied arguments. 
test -d $1  || exit 2
test -d $2 && SRC_DIR=$2 || SRC_DIR="/usr/src" 
test -d $SRC_DIR || exit 3

# confirm with user
echo "Attempting a symbolic link of ${1} to ${SRC_DIR}/linux"
echo "Press [Enter] to continue! ^c to quit"
read

# remove prior linux link otherwise break if unable. 
cd $SRC_DIR > /dev/null 2>&1 || exit 6
unlink linux > /dev/null 2>&1 || \
        test ! -e linux || \
        rm -vrI linux || exit 9

# New src to sybolic linux link
ln -s $1 linux > /dev/null 2>&1 || exit 13

# copy running systems config
zcat /proc/config.gz > linux/.config
zcat /proc/config.gz > linux/config-current

test -r ${SRC_DIR}/linux/config-current -a -r \
        ${SRC_DIR}/linux/.config || exit 23

cd
/usr/bin/genkernel \
        --makeopts="-j8" \
        --kernel-config=${SRC_DIR}/linux/config-current \
        --oldconfig \
        all

grub-mkconfig -o /boot/grub/grub.cfg




