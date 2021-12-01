#!/usr/bin/env bash
####################################
#
# Backup to remote directory.
#
####################################

# What to backup. 
backup_files="/var/www/my_app"

#location of private key for public key on remote machine
key_file="~/.ssh/my_app"

# Where to backup to keep locat backup and make a directory with same name on remote machine
dest="/home/chris/backup/my_app"

#servername on /etc/hosts
server_name="ubu18servweb06"

# Create archive filename.
name="my_app"
day=$(date +%d-%m-%y)
time=$(date +%H-%M)
archive_file="$name-$day-$time"

#database connection
database_name="travel_list"
database_user="travel_user"
database_pwd="password"

#make backup directory
path="$dest$day"
mkdir -p $dest/$day

# Print start status message.
echo "Backing up $backup_files to $dest$day"
date
echo

# Backup the files using tar.
mysqldump -u $database_user $database_name > $dest$day/$archive_file.sql
tar czf $dest$day/$archive_file.tgz $backup_files

#applying retention
old_date=`date --date="$retention_days day ago" +%d-%m-%y`
old_path="$dest$old_date"
rm -rf $old_path > /dev/null 2>&1

#copy to remote directory backup
scp -i $key_file $dest$day/$archive_file chris@$server_name:$dest$day

#Print end status message.
echo
echo "Backup finished"
date