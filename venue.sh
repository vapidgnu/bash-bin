
#!/bin/bash

function is_env_mounted {
    for MP in / /sys /dev /proc; do
        mountpoint $MP
    done
}


#CHROOT='/' && SYS='/sys' && DEV='/dev' && PROC='/proc'
CHROOT='/' ; SYS='/sys' ; DEV='/dev' ; PROC='/proc'
function is_mounted_v() {
    mountpoint ${CHROOT}
    mountpoint ${SYS}
    mountpoint ${DEV}
    mountpoint ${PROC} 
}

## or . ...

M_LIST='/ /sys /dev /proc'
function IS_MOUNTED() {
    for P in $(echo $M_LIST); do
        mountpoint $P 2> /dev/null
    done
}
## or . ...

A_LIST=(/ /sys /dev /proc)
function A_MOUNTED() {
    for D in ${A_LIST[@]}; do
        mountpoint ${A_LIST[@]} 2> /dev/null
    done
    return 0
}

function is_root() {
    if [[ "$UID" -ne 0 ]]; then
        echo "Must be root to run: $(basename $0)"
	exit 
    fi
}

function IS_ROOT() {
    [[ "$UID" -ne 0 ]] && \
    echo "Must be root to run: $(basename $0)" && \
    exit
}


