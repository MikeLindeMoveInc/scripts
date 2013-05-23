#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Must be root to run this script."
  exit
fi

repo_path=/etc/yum.repos.d/webmin.repo
repo_content="[Webmin]
\nname=Webmin Distribution Neutral
\nmirrorlist=http://download.webmin.com/download/yum/mirrorlist
\nenabled=1"
touch $repo_path
echo -e $repo_content > $repo_path

cd /tmp/env_setup/
wget http://www.webmin.com/jcameron-key.asc
rpm --import /tmp/env_setup/jcameron-key.asc

yum install webmin -y
