#!/bin/sh
touch_state=$(synclient -l | egrep 'TouchpadOff.*= 1')
if [ -z "$touch_state" ]; then
    # touchpad is on, switch it off
    synclient touchpadoff=1
else # touchpad is off, switch it on
    synclient touchpadoff=0
fi
exit 0
