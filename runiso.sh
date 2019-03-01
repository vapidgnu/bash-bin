#!/bin/bash

#find test to run e.g test if iso
# add peram for memory allocation
# a case for system boot type?

#sloppy
 qemu-system-x86_64 -boot d -cdrom ${1} -m 512



