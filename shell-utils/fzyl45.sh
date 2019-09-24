#!/bin/bash
# Program phzy
# fzy as pager w/45 lines of text
LINES=$2

if [ -f $1 ]; then
	FILE1=$1
	else
	exit 1
fi

if [ "${LINES}" -ge "45" ]; then
	cat  $FILE1 | fzy -l ${LINES}
else
	cat $FILE1 | fzy -l45
fi

