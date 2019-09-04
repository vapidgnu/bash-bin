#!/bin/bash

line='!!!line UNSET!!!'
PATTERN="$1"
STRING="$2"
file="$3"



if [[ -z "$PATTERN" && \
      -z "$STRING" && \
      -z "$FILE" ]]; then
    echo "Usage: $(basename $0) PATTERN STRING FILE."
else
    if [ -r $FILE ]; then  
        while read FILE; do
    #       echo ${PATTERN//$STRING/$FILE$}
           MOD=${PATTERN//$STRING/$FILE$}
        done < $3 
    fi
fi

