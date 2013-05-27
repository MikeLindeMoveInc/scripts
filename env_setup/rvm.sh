#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "This script must be run as root."
  exit
fi

# Install SQLite, if necessary
yum install patch gcc-c++ readline-devel zlib-devel libyaml-devel libffi-devel openssl-devel autoconf automake libtool bison libxml2-devel libxslt-devel sqlite -y

# Install RVM
curl -L https://get.rvm.io | bash -s stable 
