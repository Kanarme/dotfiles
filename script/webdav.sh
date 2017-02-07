#!/bin/sh
path="/oyra"

while [ 1 ]; do
	ping -c1 oyra.eu &> /dev/null # Ping command returns an exit code, if exit code = 0 sucsess 
	if [ $? -eq 0 ] # $? returns exit code
	then

		if mount | grep $path > /dev/null; then
			chown -R user:users $(find $path -mindepth 1 -maxdepth 1 -not -name "lost+found") 
		else
		mount -t davfs https://cloud.oyra.eu/seafdav $Path 
		chown -R user:users $(find $path -mindepth 1 -maxdepth 1 -not -name "lost+found")  
		fi
	else
		sleep 30s
		ping -c1 oyra.eu &> /dev/null  
		if [ $? -ne 0 ] # not equal
		then 
			umount $path
		fi
	fi
	sleep 3s
done
