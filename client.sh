#!/bin/bash
HOME_DIR="/home/asheesh/Projects/libllcp"    #for asheesh's laptop
#HOME_DIR=~"/libllcp"              #for varun's laptop
WAIT=4                            # to synchronize with the server
# to check whether the nfc device is opened or not
if [ "`ls /dev/ttyUSB*`" != "/dev/ttyUSB0" -a "`ls /dev/ttyUSB*`" != "/dev/ttyUSB1" ]
then
    echo "nfc device not opened" 
    exit
fi

chmod +x $HOME_DIR/examples/snep-client/command.txt
. $HOME_DIR/examples/snep-client/command.txt

chmod +x $HOME_DIR/examples/snep-client/config.txt
. $HOME_DIR/examples/snep-client/config.txt

#session 1 started
$HOME_DIR/examples/snep-client/snep-client p $HOME_DIR/examples/snep-client/command.txt p $HOME_DIR/examples/snep-client/config.txt
#session 1 ended
DURATION=$(($DURATION+$WAIT))
sleep $DURATION       #sleep for the duration(time for taking the readings) + 1 amount of time


touch $HOME_DIR/examples/snep-client/output.txt
#session 2 started
$HOME_DIR/examples/snep-client/snep-client g output.txt
#session 2 ended

cat output.txt           #print the data received
if [ -f $HOME_DIR/examples/snep-client/output.txt ]
then
    rm $HOME_DIR/examples/snep-client/output.txt
fi
