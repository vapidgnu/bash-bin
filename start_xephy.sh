#!/bin/bash
# start 800x600 nested x server
Xephyr -ac -nolisten tcp -br -noreset -screen 800x600 :1
