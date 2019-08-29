#!/bin/bash

ACONF=$1

if [ -f "${ACONF}"  ]; then
    DISPLAY=:1.0
    awesome -c $ACONF
else
   exit 1
fi
