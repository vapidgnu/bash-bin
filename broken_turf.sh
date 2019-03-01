#!/bin/bash
# "st" doesn't start tabbed this way. hmm. ...

sakura -t "turf.stdo" -e tabbed -c surf -e || xprop -id $WINDOWID -f WM_CLASS 8t -set WM_CLASS "turf" 
