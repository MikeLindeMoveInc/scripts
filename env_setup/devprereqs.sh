#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Must be root to run this script."
  exit
fi

# Add the EPEL to the repos
rpm -i https://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum install gcc kernel-devel make perl wget git -y
