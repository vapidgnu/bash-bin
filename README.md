# bash-bin
   some use(full/less) Bash utilities, I place them in ${HOME}/bin.


### mostly practice code, and test scripts. Maybe something is useful for you.
* toolings for AwesomeWM, gentoo and perhaps others. 
* If you want to deploy any of this code, good luck. 

# three scripts to install gentoo!
## `./setup-gentoo-drive.sh`
* run first!
* best ran from the gentoo minimal install image because: 
* doesn't test if `/dev/shm` is a symlink. *WILLFIX*
* if installing from ubuntu `test -L /dev/shm && echo is symlink` will tell you
## `./set-post-chroot`
* run once inside the chroot
* needs work, and a way to drop in your own /etc/portage configs easily 
* how it fetches and decompress from github is gross as fuck. sorry. 
## `./simple_genkern_update.sh /usr/src/linux-kernel-version`
* first argument needs to be the location of the kernel source e.g. `/usr/src/linux-4.19.66-gentoo`
* needs further testing

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
### set-pst-chroot.sh
* fetches /etc/portage and /var/db/portage/world contents from github
* installs base system based on new updated configurations
* a pretty basic gentoo desktop installation. 
### simple_genkern_update.sh
* trying to be posix compliant, please complain if it isn't. 
