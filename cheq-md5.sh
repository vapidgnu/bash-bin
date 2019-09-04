#!/bin/bash
# run equery check '*/*' in batches



for x in $( ls /usr/portage | grep \- ); do
	equery check "${x}/*" #&> /tmp/EQUERRY_md5.${x}.$$
done

