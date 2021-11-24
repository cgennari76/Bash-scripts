#!/bin/sh
#run this on each server
for i in "$@"; do
    echo creating user: "$i"
    sudo adduser $i

    echo add user to sudo group
    sudo usermod -aG sudo $i

    echo creating ssh folder and authorized_keys
    sudo -H -u $i bash -c 'mkdir -p /home/"$0"/.ssh' $i
    sudo -H -u $i bash -c 'chmod 700 /home/"$0"/.ssh/' $i
    sudo -H -u $i bash -c 'touch /home/"$0"/.ssh/authorized_keys' $i
    sudo -H -u $i bash -c 'chmod 600 /home/"$0"/.ssh/authorized_keys' $i
done
