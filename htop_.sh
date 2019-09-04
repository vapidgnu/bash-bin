#!/bin/sh

awesome-client 'awful = require ("awful");
  awful.spawn("sakura --name HTOP -e /bin/sh -c htop ", {
    floating  = true,
    tag       = mouse.screen.selected_tag,
    placement = awful.placement.botton_right,
})'
