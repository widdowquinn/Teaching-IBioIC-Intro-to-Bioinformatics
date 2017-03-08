#!/usr/bin/env bash
#
# create_users.sh
#
# Short helper script to set up generic users for the IBioIC VM.
#
# Usernames and passwords are read from the file users.txt, which contains
# entries in the format:
#
# user1,password1
# user2,password2
#
# Prior to running, assumes you have updated the course material with:
#
# cd /home/ibioic/IBioIC/Teaching-IBioIC-Intro-to-Bioinformatics
# git checkout master
# git pull
#
# Run this script as su/with sudo to delete all old user data, and recreate
# the users:
#
# sudo create_users.sh > create_users.log

for udetails in `cat users.txt`
do

    user=`echo $udetails | cut -f 1 -d ,`
    pass=`echo $udetails | cut -f 2 -d ,`
    remcmd="userdel -r ${user}"
    echo ${remcmd}
    ${remcmd}
    mkcmd="useradd -m -d /home/${user} -p `mkpasswd ${pass}` ${user}"
    echo ${mkcmd}
    ${mkcmd}
    # Root account uses $HOME/IBioIC/Teaching-IBioIC-Intro-to-Bioinformatics
    # but user accounts $HOME/Teaching-IBioIC-Intro-to-Bioinformatics
    cpcmd="cp -R /home/ibioic/IBioIC/Teaching-IBioIC-Intro-to-Bioinformatics /home/${user}"
    echo ${cpcmd}
    ${cpcmd}
done
