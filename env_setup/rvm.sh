#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -eq "$ROOT_UID" ]; then
  echo "Do not run this script as root. sudo will be used when required."
  exit
fi

# Install SQLite, if necessary
sudo yum install patch gcc-c++ readline-devel zlib-devel libyaml-devel libffi-devel openssl-devel autoconf automake libtool bison libxml2-devel libxslt-devel sqlite -y

# Install RVM
curl -L https://get.rvm.io | bash -s stable 
