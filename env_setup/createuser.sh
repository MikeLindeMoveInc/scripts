#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Must be root to run this script."
  exit
fi

# Verify arguments
if [ "$#" -eq 2 ]; then
  user_name=$1
  password=$2
else
  echo "Usage: $0 user_name password"
  exit
fi

# Test whether the user exists
grep $user_name /etc/passwd > /dev/null
if [ "$?" -eq 0 ]; then
  echo "The user already exists."
  exit
fi

# Create user
useradd -d /home/$user_name -m $user_name
echo $password | passwd $user_name --stdin

# Allow the user to be able to execute sudo
chmod +w /etc/sudoers
echo "$user_name ALL=(ALL) ALL" >> /etc/sudoers
chmod 440 /etc/sudoers
