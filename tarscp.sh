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
day=$(date +%m%d%y)
time=$(date +%H:%M)
archive_file="$name-$day-$time"

#database connection
database_name="travel_list"
database_user="backup_user"
database_pwd="backup1"

# Print start status message.
echo "Backing up $backup_files to $dest$day"
date
echo

#Make the backup directory, dump mysql, and gzip a backup file of the app
path="$dest$day"
mkdir -p $path
mysqldump -u $database_user -p$database_pwd -h localhost $database_name > $path/"$archive_file".sql
tar czf $path/"$archive_file".tgz $backup_files

#copy to remote directory backup
scp -r -i $key_file $path chris@$server_name:$path

#applying retention
old_date=`date --date="$retention_days day ago" +%d-%m-%y`
old_path="$dest$old_date"
rm -rf $old_path > /dev/null 2>&1

#Print end status message.
echo
echo "Backup finished"
date