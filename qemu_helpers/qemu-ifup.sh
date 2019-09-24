#!/bin/sh
# qemu-ifup.sh

set -x
TAP=$1
BRIDGE=br0

if [ -n "$1" ];then # first ARG must be tapN e.g. tap2
        ip tuntap add ${TAP} mode tap user ${USER} # group kvm
        ip link set ${TAP} up
        sleep 0.5s
        ip link set ${TAP} master ${BRIDGE}
        exit 0
else
        echo "Error: no interface specified"
        exit 1
fi
