#!/bin/env bash
###########################################################
#
# This script installs docker and docker-compose
#
###########################################################

function check_run_as_root() {
   if [[ $EUID -ne 0 ]]; then
      echo "This script needs to be run as root/sudo"
      exit 1
   fi
}

function check_parameters() {
   if [[ "$#" -ne 1 ]]; then
      echo "Need to pass user to add to the docker group"
      exit 1
   fi
   cut -d: -f1 /etc/passwd | grep -q $1
   if [[ $? -ne 0 ]]; then
      echo "User $1 not found"
      exit 1
   fi
}

check_run_as_root
check_parameters $@

# update and upgrade
apt-get -y update > /dev/null
apt-get -y upgrade > /dev/null

# install and start docker
apt-get -y install docker.io > /dev/null
systemctl enable --now docker

# and add user to group
usermod -aG docker $1 > /dev/null

# install docker-compose
apt-get -y install docker-compose > /dev/null

echo "You must log out and back in for the changes to take effect"

