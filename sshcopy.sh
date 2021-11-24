#!/bin/sh
#run from the ssh folder
for i in "$@"; do
        sudo -H bash -c 'ssh-copy-id -i "$0".pub "$0"@ubu18servweb04' $i
done
