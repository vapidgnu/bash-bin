#!/bin/sh
# USAGE: cdmode ISO DISK_IMAGE IP_AND_DISPLAY_PORT IMAGE_FORMAT
# TODO, add better argument handling? getopts? case statement? 



RAM="8192M"
IP="10.0.10.100"


test -n "$1" && ISO="${1}" || exit 2

# TODO: test $2 for type and set $FMT

test -n "$2" && IMG="${2}" || exit 3

if [ -n "$3" ]; then
	VNC="${IP}:${3}"
	echo "VNC:${VNC}"
else
	VNC='192.168.0.123:6' # a hard coded fallback 
	echo "VNC:${VNC}"
fi	 

if [ ! -n "$4" ]; then
	echo "WARMING FORMAT MUST BE SET. e.g. raw, qcow2"
	exit $?
else
        FMT=$4
fi


# TODO: enable user to run qemu with kvm
# 
sudo qemu-system-x86_64 \
--display vnc=${VNC} \
-cdrom ${ISO} \
-boot order=d \
-drive file=${IMG},format=raw \
-m ${RAM} --enable-kvm \
-device virtio-net,netdev=network0 \
-netdev tap,id=network0,ifname=tap0,script=no,downscript=no



	
