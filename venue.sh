
#!/bin/bash



CHROOT='/' && SYS='/sys' && DEV='/dev' && PROC='/proc'
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
        mountpoint $P &> /dev/null
    done
}
#

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


