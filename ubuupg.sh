#!/bin/sh
#check the packages on each server cat /var/log/apt/history.log
log="/tmp/apt-get.log"
>"${log}"
for s in $(cat servers.txt )
do 
   echo "Updating and patching $s, please wait..." | tee -a "${log}"
   ssh chris@${s} "sudo apt-get -q -y update" >/dev/null
   ssh chris@${s} "sudo DEBIAN_FRONTEND=noninteractive apt-get -y -q upgrade" >>"${log}"
done
echo "Check $log file for details."
