#!/bin/sh
# Change color schemes on the fly. 
# Sample usage: ./term-recolor.sh < ~/.Xresources


# pulled off of superuser.com
# supposedly supports terminals
# that suport Xterm OSC ESCAPE
# sequences

tr -d ' \t' | sed -n '
s/.*background:/\x1b]11;/p
s/.*foreground:/\x1b]10;/p
s/.*color\([0-9][^:]*\):/\x1b]4;\1;/p
' | tr \\n \\a

