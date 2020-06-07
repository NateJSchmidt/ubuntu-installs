#!/bin/env bash
###########################################################
#
# This script installs python3-dev and python3-venv
#
###########################################################

function check_run_as_root() {
   if [[ $EUID -ne 0 ]]; then
      echo "This script needs to be run as root/sudo"
      exit 1
   fi
}

check_run_as_root

apt-get -y update > /dev/null
apt-get -y upgrade > /dev/null

apt-get -y install python3-dev python3-pip python3-venv > /dev/null
if [[ $? -eq 0 ]]; then
   echo "python3-dev, python3-pip, and python3-venv installed"
else
   echo "There was a problem installing python libraries"
fi

