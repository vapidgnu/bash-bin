#!/bin/bash
# add an aliased command to a list
# then try to source that list. 

# TODO remove duplicate lines
RC=${HOME}/.saliasrc

C=$1
shift 1

function _save_alias {
  echo alias ${C}=\'${@}\' >> ${RC}
}
_save_alias $@
 
source ${RC}

function _set_alias {
  local IFS="\n"  
  for a in $(cat ${RC}); do
    echo $(echo ${a})
  done
}
#_set_alias
