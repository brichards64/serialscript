#!/bin/bash
#6 off, 38 on

while true
do
	if [ `qm status 107 | awk '{print $2}'` == 'stopped' ]
	then
		echo stopped
		if [ `statserial -d /dev/ttyUSB0` -eq 6 ]
		then
			echo stopped and sleeping
			sleep 10
		else
			echo starting
			tmp=$(expr `pvecm status | grep Nodes | awk '{ print $2 } '` \* 3)
			echo $tmp
			pvecm expected $tmp
			qm start 107
			echo started
		fi

	elif [ `qm status 107 | awk '{print $2}'` == 'suspended' ]
		then
			echo suspended
			if [ `statserial -d /dev/ttyUSB0` -eq 6 ]
			 then
				echo suspended and sleeping
                        	sleep 10 
			 else
				echo resuming
				tmp=$(expr `pvecm status | grep Nodes | awk '{ print $2 } '` \* 3)
				echo $tmp
				pvecm expected $tmp
                        	qm resume 107
				echo resumed
                  	 fi

	else
	echo computer on
	sleep 10

	fi
done
