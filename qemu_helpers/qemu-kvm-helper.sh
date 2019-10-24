#!/bin/bash
# qemu-kvm-helper.sh WIP
# auth: me! silly.
# Script to start qemu with kvm enabled.
# Doesn't error when it could.

# Good default vaules to set:
# Leave blank if you want to use this script to write
# custom start-up scripts for you with the -W flag.
# CDROM doesn't nothing right now.
DRIVE=;FORMAT=;RAM=;CORES=;HOST_IP=;TAP_DEV=;MAC=;VNC=

USAGE="
USAGE: $(basename $0) -r RAM[k/m/g], -c CORES, -d /path/to/drive,
-C /path/to/iso, -f {raw,qcow2}, -h host IP, -t tap device, -m MAC addr,
-v VNC display port, -S [Runs the command], -W writes to qkvm-[FILE].sh
"

# unset
STARTER=

# command args
declare -A ARGS
ARGS=(\
        [RAM]=${RAM}\
        [CORES]=${CORES}\
        [DRIVE]=${DRIVE}\
        [CDROM]=${CDROM}\
        [FORMAT]=${FORMAT}\
        [HOST_IP]=${HOST_IP}\
        [TAP_DEV]=${TAP_DEV}\
        [MAC]=${MAC}\
        [VNC]=${VNC} )

die () {
        echo -e "$?\n$@" && exit 1
}

isnt() {
        test -z $1
}

start_qemu () {
         sudo qemu-system-x86_64 \
                -enable-kvm -smp cpus=${CORES} \
                --display vnc=${HOST_IP}:${VNC} \
                -drive file=${DRIVE},format=${FORMAT} \
                -m ${RAM} \
                -device virtio-net,netdev=network0 \
                -netdev tap,id=network0,ifname=${TAP_DEV},\
                mac=${MAC},script=no,downscript=no
}

write_config () {
        cat << EOF > qkvm-${1}.sh
$( echo sudo qemu-system-x86_64 \
                -enable-kvm -smp cpus=${CORES} \
                --display vnc=${HOST_IP}${VNC} \
                -drive file=${DRIVE},format=${FORMAT} \
                -m ${RAM} \
                -device virtio-net,netdev=network0 \
                -netdev tap,id=network0,ifname=${TAP_DEV},\
                mac=${MAC},script=no,downscript=no )
EOF
}

# get commands options
while getopts r:c:d:C:f:i:t:m:v:W:S opt; do
        case "${opt}" in
                r) RAM=$OPTARG;;
                c) CORES=$OPTARG;;
                d) DRIVE=$OPTARG;;
                C) CDROM=$OPTARG;;
                f) FORMAT=$OPTARG;;
                i) HOST_IP=$OPTARG;;
                t) TAP_DEV=$OPTARG;;
                m) MAC=$OPTARG;;
                v) VNC=$OPTARG;;
                W) write_config $OPTARG;;
                S) STARTER=1;;
                *) die $USAGE
        esac
done

# Hope only one interface is "UP"
# Don't use.
IPADDR=$(ip -br a | grep UP | cut -d/ -f 1 | awk '{print $3}')

# set defaults if not set or do nothing otherwise.
# boring; TODO: test each var for what it needs to be or err out.
echo '###################################'
echo '# will run KVM enabled QEMU with: #'
echo '###################################'
for x in ${!ARGS[@]}; do
        case $x in
                # probably a better way to set
                # default values other than here:
                RAM) isnt $RAM && RAM=256M;;
                CORES) isnt $CORES && CORES=1;;
                DRIVE) isnt $DRIVE && DRIVE=;;
                CDROM) isnt $CDROM && CDROM=;;
                FORMAT) isnt $FORMAT && FORMAT=raw;;
                HOST_IP) isnt $HOST_IP && HOST_IP=$IPADDR;;
                TAP_DEV) isnt $TAP_DEV && TAP_DEV=tap0;;
                MAC) isnt $MAC && MAC=$(macgen.sh);;
                VNC) isnt $VNC && VNC=:3;;
        esac
        # double negitive wtf?
        echo  "${x}:${!x}"
done
# run command if -S flag was used
isnt $STARTER || start_qemu
