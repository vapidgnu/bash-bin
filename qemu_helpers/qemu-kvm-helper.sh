# messy

# get commands options

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
        echo $@ && exit ?
}

isnt() {
        test -z $1
}

start_qemu () {
     echo   sudo qemu-system-x86_64 \
                -enable-kvm \
                --display vnc=${HOST_IP}${VNC} \
                -drive file=${DRIVE},format=${FORMAT} \
                -m ${RAM} \
                -device virtio-net,netdev=network0 \
                -netdev tap,id=network0,ifname=${TAP_DEV},\
                mac=${MAC},script=no,downscript=no
}

while getopts r:c:d:C:f:h:t:m:v:S opt; do
        case "${opt}" in
                r) RAM=$OPTARG;;
                c) CORES=$OPTARG;;
                d) DRIVE=$OPTARG;;
                C) CDROM=$OPTARG;;
                f) FORMAT=$OPTARG;;
                h) HOST_IP=$OPTARG;;
                t) TAP_DEV=$OPTARG;;
                m) MAC=$OPTARG;;
                v) VNC=$OPTARG;;
                S) start_qemu;;
                *) echo 'need args!'
        esac
done

# print usless test output
echo "var tests: $RAM $CORES $DRIVE $CDROM $FORMAT $HOST_IP"
IPADDR=$(ip -br a | grep UP | cut -d/ -f 1 | awk '{print $3}')

# set defaults if not set or do nothing otherwise.
# boring; TODO: test each var for what it needs to be or err out.
for x in ${!ARGS[@]}; do
        case $x in
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
        echo  "${x} is ${!x}"
done


# print command that would be ran without tabs for copy/pasting
echo command: $( echo "    sudo qemu-system-x86_64 \
                -enable-kvm \
                --display vnc=${HOST_IP}${VNC} \
                -drive file=${DRIVE},format=${FORMAT} \
                -m ${RAM} \
                -device virtio-net,netdev=network0 \
                -netdev tap,id=network0,ifname=${TAP_DEV},\
                mac=${MAC},script=no,downscript=no
"

)
