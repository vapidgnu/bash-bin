
#!/bin/bash



CHROOT='/' ; SYS='/sys' ; DEV='/dev' ; PROC='/proc'
is_mounted_v()
{
    mountpoint ${CHROOT}
    mountpoint ${SYS}
    mountpoint ${DEV}
    mountpoint ${PROC} 
}

## or . ...

M_LIST='/ /sys /dev /proc'
IS_MOUNTED()
{
    for P in $(echo M_LIST); do
        mountpoint $P 2> /dev/null
    done
}
## or . ...

A_LIST=(/ /sys /dev /proc)
A_MOUNTED()
{
    for D in ${A_LIST[@]}; do
        mountpoint ${A_LIST[@]} 2> /dev/null
    done
    return 0
}

function func()
{
    echo '$@: '$@
    echo "1:$1 2:$2 3:$3 4:$4"
    echo "number of args $#"
}

is_root()
{
    if [[ "$UID" -ne 0 ]]; then
        echo "Must be root to run: $(basename $0)"
	exit 1
    fi
}

IS_ROOT()
{
    [[ "$UID" -ne 0 ]] && \
    echo "Must be root to run: $(basename $0)"
}

CMD="$0"
CMD_ARGS="$@"
CHROOT="$1"
SHELL="$SHELL"

if [[ -z ${CHROOT} && ! -d ${CHROOT} ]]; then
    echo "${CHROOT} must be a directory"
    exit 2 
fi


