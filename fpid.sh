#!/bin/bash
# find PID of $1 if $1 is a able to be parsed from ps aux
# Future: add a flag to print running process name, and PID
# add a flag to kill PID found. these funtions most likely
# have been deveopled else where.

FPIDS=$(ps aux | grep -v "grep" | grep ${1} |  awk '{print $2}')
FPNMS=$(ps aux | grep ${1} | grep -v "grep" | awk '{print $11}')
FPIDN=$(ps aux | grep ${1} | grep -v "grep" | awk '{print $2":"$11}')

for x in $FPIDS; do 
	echo $x; 
done
