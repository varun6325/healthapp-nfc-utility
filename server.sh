#!/bin/bash
HOME_DIR="/home/pi"
WAIT=1                 # to read the last set of readings
x=0

if [ `whoami` != "root" ] 
then
    echo "Application needs to be run as root"
    exit 1
fi


# to check whether the nfc device is opened or not
if [ "`ls /dev/ttyUSB*`" != "ttyUSB0" -a "`ls /dev/ttyUSB*`" != "ttyUSB1" ]
    echo " nfc device not opened" 
    exit 1
fi
#session 1 started
. $HOME_DIR/libs/libllcp/examples/snep-server/snep-server p /home/pi/command.txt p /home/pi/config.txt
#session 1 ended

chmod +x $HOME_DIR/command.txt
. $HOME_DIR/command.txt

chmod +x $HOME_DIR/config.txt
. $HOME_DIR/config.txt

#run the controller script
sudo $HOME_DIR/controlsw/controller.sh &
TIME=0
touch output.txt
while [ $TIME -le $DURATION + $WAIT ]
do
    if [ -f $HOME_DIR/sensor2-ir/cdat2.txt ]
    then
        cat cdat2.txt >> output.txt
	rm $HOME_DIR/sensor2-ir/cdat2.txt
    fi
    if [ -f $HOME_DIR/sensor1-ac/cdat1.txt ]
    then
        cat cdat1.txt >> output.txt
	rm $HOME_DIR/sensor1-ac/cdat1.txt
    fi
    sleep 5
    TIME =$(( $TIME+5 ))
done

#session 2 started
. $HOME_DIR/libs/libllcp/examples/snep-server/snep-server g /home/pi/output.txt
if [ -f $HOME_DIR/output.txt ]
    rm $HOME_DIR/output.txt
fi
#session 2 ended

