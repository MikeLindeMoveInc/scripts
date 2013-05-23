#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Must be root to run this script."
  exit
fi

# Verify arguments
if [ "$#" -eq 1 ]; then
  password=$1
else
  echo "Usage: $0 password"
  exit
fi

mkdir /var/devroot
chown movedev:movedev /var/devroot/
chmod 775 /var/devroot/

yum install samba samba-common -y

printf "$password\n$password\n" | smbpasswd -a -s movedev

content="[devroot]
\npath=/var/devroot
\nbrowseable=yes
\nread only=no
\ncomment=Development Root"
echo -e $content >> /etc/samba/smb.conf

smbd reload
