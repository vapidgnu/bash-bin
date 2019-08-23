#!/bin/bash

#local awesome API documentation
#ADOCS='file:////usr/share/doc/awesome-4.2-r2/doc/index.html'
ADOCS='file:////usr/share/doc/$(equery l awesome | cut -d/ -f 2 )/doc/index.html'

surf ${ADOCS}
