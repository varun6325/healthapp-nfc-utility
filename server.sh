#!/bin/bash
#HOME_DIR="~/Projects/libllcp"    #for asheesh's laptop
HOME_DIR="~/libllcp"              #for varun's laptop
WAIT=1                            # to synchronize with the server
# to check whether the nfc device is opened or not
if [ "`ls /dev/ttyUSB*`" != "ttyUSB0" -a "`ls /dev/ttyUSB*`" != "ttyUSB$
    echo " nfc device not opened" 
    exit 1
fi

chmod +x $HOME_DIR/examples/snep-client/command.txt
. $HOME_DIR/examples/snep-client/command.txt

chmod +x $HOME_DIR/examples/snep-client/config.txt
. $HOME_DIR/examples/snep-client/config.txt

#session 1 started
. $HOME_DIR/examples/snep-client/snep-client p command.txt p config.txt
#session 1 ended

sleep($DURATION+$WAIT)       #sleep for the duration(time for taking the readings) + 1 amount of time


touch output.txt
#session 2 started
. $HOME_DIR/examples/snep-client/snep-client g output.txt
#session 2 ended

cat output.txt           #print the data received

