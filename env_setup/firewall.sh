#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Must be root to run this script."
  exit
fi

# Disable SELinux
echo 'SELINUX=disabled' > /etc/selinux/config

# Flush & save IPTables
iptables -F
service iptables save
