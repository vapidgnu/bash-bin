#!/bin/sh
# TODO:
# functions: log output and die function.
# test root? why? Also could just insall in 
# userland chroot to an extent.

USRNAME=        # default larry
GROUPS='wheel,portage,audio,video,usb,cdrom'
TZ=             # default America/Los_Angeles
PROFILE='default/linux/amd64/17.1/desktop' # defaults to latest s/desktop
GIT='https://github.com/vapidgnu/'
WORLD_FILE='https://raw.githubusercontent.com/vapidgnu/var-lib-portage/master/world'


un_zip() {
        cd $1 || exit $?
        test ! -e $2 && exit $?
        unzip $2 && rm $2
        cd -
}

# if newer portage location isn't set
# TODO: remove
test -d /var/db/repos/gentoo/ || mkdir /var/db/repos/gentoo && \
        test -d /usr/portage && rm -rf /usr/portage

source /etc/profile
#are we interactive?
#export PS1="Chroot ${PS1}"
env-update
emerge-webrsync

# set gentoo PROFILE to latest stable desktop if not set
test -z $PROFILE && \
        PROFILE=$(eselect profile list | \
        awk '/desktop\ / && /stable/' | \
        tail -n1 | awk '{print $2}')

eselect profile set ${PROFILE}

test -z $USRNAME && USRNAME='larry' || USRNAME=$USRNAME
test -z $GROUPS && GROUPS='wheel' || GROUPS=$GROUPS
useradd -g users -G "${GROUPS}" -m ${USRNAME}
#passwd ${USRNAME}

# Fetch /etc/portage contents
wget ${GIT}lap0-etc-portage/archive/master.zip -O /etc/portage/CONF.zip || exit $?
# decompress /etc/portage
# cd $1; unzip $2; rm $2; cd -
un_zip /etc/portage CONF.zip
cd /etc/portage
mv lap0-etc-portage-master/* . && rmdir lap0-etc-portage-master
cd -


wget ${WORLD_FILE} -O /var/db/portage/world || exit $?

#TODO
# echo 'app-editors/vim X cscope gpm lua perl python terminal vim-pager' > /etc/portage/package.use/app-editors.vim
# install extra  packages
#emerge -vquNkG vim

# TODO
emerge -qv gentoo-sources

# install "SYSTEM" packages
emerge -vquNDkG world || exit $?



### System Configurations
# Create /etc/env.d/02locale
cat << EOF > /etc/env.d/02locale
LANG="en_US.UTF-8"
LC_COLLATE="C"
EOF

# Create /etc/conf.d/net
cat << EOF > /etc/conf.d/net
dns_domain_lo="pub.local"
EOF

# TIMEZONE info set PST as default.
test -z $TZ && TZ="America/Los_Angeles" || TZ=$TZ
ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime
