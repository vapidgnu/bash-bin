#!/bin/sh

APP=$1
APP_NAME=$2

echo $APP
echo $APP_NAME
read

awesome-client 'awful = require ("awful");
  awful.spawn("sakura --name $APP_NAME -e /bin/sh -c $APP ", {
    floating  = true,
    tag       = mouse.screen.selected_tag,
    placement = awful.placement.botton_right,
})'
