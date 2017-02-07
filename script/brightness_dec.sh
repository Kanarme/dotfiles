#!/bin/sh
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
echo $((current_brightness-10)) | tee /sys/class/backlight/intel_backlight/brightness

