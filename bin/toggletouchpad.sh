#!/bin/bash

enabled=$(xinput list-props 12 | grep "Device Enabled" | grep -o "[01]$")
id=$(xinput --list | rg "Touchpad" | grep -o "id=.." | cut -f 2 -d '=')

if [ $enabled == '1' ]; then
    xinput disable $id
else
    xinput enable $id
fi
