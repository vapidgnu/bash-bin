#!/bin/bash

#fuck up your terminal with testing fonts
# $1 = name of font; don't fuck it up
# $2 = style of font; don't fuck it up
# $3 = pixelsize; again, don't fuck it up

# let's try and set sain defaults, so if you like forget
# to to use style or pixel size

FNT=;PIX=;STY=

die()
{
   echo "Usage: $(basename $0) Pixelsize Style"
   echo "e.g. $(basename $0) 13 Regular"
}


FNT=$1; PIX=$2; STY=$3

[[  -z $STY && -z $PIX ]] || PIX=13; STY=Regular
[ -z $FNT ] || die

# this command should change the current terminal
# emulators font.

printf \e]710;%s\007 xft:${FNT}:style=${STY}:pixelsize=${PIX}




