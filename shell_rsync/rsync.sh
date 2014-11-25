#!/bin/bash
source config.cfg

mkdir -p /root/backup_data/{controller,compute,network}

#ssh-keygen -R root@$CONTROLLER
#ssh-keygen -R root@$COMPUTE
#ssh-keygen -R root@$NETWORK

apt-get install sshpass

sshpass -p $PASSCONT rsync -avz --delete -e ssh root@$CONTROLLER:$SRCCONT $DESTCONT
sshpass -p $PASSCOM rsync -avz --delete -e ssh root@$COMPUTE:$SRCCOM $DESTCOM
sshpass -p $PASSNET rsync -avz --delete -e ssh root@$NETWORK:$SRCNET $DESTNET
