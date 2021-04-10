#!/bin/bash

mute=$(pactl list sinks | grep '^[[:space:]]Mute:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

if [[ "$mute" =~ "yes" ]]; then
    echo "muted"
else 
    echo "unmuted"
fi

