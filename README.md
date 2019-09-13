# bash-bin
   some use(full/less) Bash utilities, I place them in ${HOME}/bin.


### mostly practice code, and test scripts. Maybe something is useful for you.
* toolings for AwesomeWM, gentoo and perhaps others. 
* If you want to deploy any of this code, good luck. 

### setup-gentoo-drive.sh
* Pretty broken but works if all things are lined up
* will complain
* So far it:
* asks for a drive e.g. /dev/sda
* formats it: boot /dev/sda1; boot/efi /dev/sda2; swap /dev/sda3; root /dev/sda4
* with the ext4 filesystem, and FAT32 for the UEFI partition
* the Manual formating option isn't fully functional
* fetches lateset stage3 from gentoo; and install it.
* sets you up in a basic chroot environment
* doesn't test networking. 

### simple_genkern_update.sh
* trying to be posix compliant, please complain if it isn't. 

### prekernel_chroot.sh
* run after disk_mount.sh && env_mount.sh
* both disk_mount.sh and env_mount.sh are pretty basic, but are hard coded

### disk_mount.sh
* needs some level of dynamic assessment of the disk space
* also need to write/find useful snippets for partition schemes. 
