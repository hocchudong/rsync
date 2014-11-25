#!/bin/bash
source /root/shell_rsync/config.cfg

mkdir -p /root/backup_data/{controller,compute,network}


apt-get install sshpass

sshpass -p $PASSCONT rsync -avz --delete -e ssh root@$CONTROLLER:$SRCCONT $DESTCONT
sshpass -p $PASSCOM rsync -avz --delete -e ssh root@$COMPUTE:$SRCCOM $DESTCOM
sshpass -p $PASSNET rsync -avz --delete -e ssh root@$NETWORK:$SRCNET $DESTNET
