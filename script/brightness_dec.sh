#!/bin/sh
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
if [ "$current_brightness" -ge 250 ] && [ "$current_brightness" -le 500 ]; then
	echo $((current_brightness-20)) | tee /sys/class/backlight/intel_backlight/brightness
else
        echo $((current_brightness-10)) | tee /sys/class/backlight/intel_backlight/brightness

fi

