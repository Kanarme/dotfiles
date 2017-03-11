#!/bin/sh

gxmessage  "Ich brauche mehr Details!" -center -title "Shutdown" -font "Sans bold 10" -default "Cancel" -buttons "_Cancel":1,"_Logout":2,"_Reboot":3,"_Shutdown":4 >/dev/null

case $? in
	1)
	echo "Exit";;
	2)
	i3lock -c 000000 -n -f -I 10;;
	3)
	shutdown -r now;;
	4)
	shutdown -h now;;
esac
