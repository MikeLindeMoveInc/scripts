#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Must be root to run this script."
  exit
fi

repo_path=/etc/yum.repos.d/10gen.repo
repo_content="[10gen]
\nname=10gen Repository
\nbaseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64
\ngpgcheck=0
\nenabled=1"
touch $repo_path
echo -e $repo_content > $repo_path

yum install mongo-10gen mongo-10gen-server -y
