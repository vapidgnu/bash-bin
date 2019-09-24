#!/bin/bash
# Program phzy and a little loopy
# fzy as interactive copy x buffer 
# pager w/45 lines of text
# required args: FILE, n
# FILE could be any readable file, 
# n is a number, defaults to 45, set in LINES
# e.g.  loopfuz.sh FILE n
#

LINES="45"
LINES=$2

if [ -f $1 ]; then
  FILE=$1
 else
  exit 1
fi


if [ "${LINES}" -ge "45" ]; then
  while true; do
    cat  $FILE | fzy -l ${LINES} | xclip
  done
 else
  while true; do
    cat $FILE | fzy -l45 | xclip
  done
fi
