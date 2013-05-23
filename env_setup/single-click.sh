#! /bin/bash

# Do not run as root
ROOT_UID=0
if [ "$UID" -eq "$ROOT_UID" ]; then
  echo "Do not run this script as root. sudo will be used when required."
  exit
fi

# Verify arguments

if [ "$#" -eq 3 ]; then
  
  target_machine_ip=$1
  user_name=$2
  password=$3

else

  echo "Usage: $0 target_machine_ip user_name password"

  exit

fi

ssh $target_machine_ip -l root <<EOF

yum install wget -y

mkdir -p /tmp/env_setup
cd /tmp/env_setup

wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/createuser.sh -O /tmp/env_setup/createuser.sh
sh /tmp/env_setup/createuser.sh $user_name $password

wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/firewall.sh -O /tmp/env_setup/firewall.sh
sh /tmp/env_setup/firewall.sh

wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/devprereqs.sh -O /tmp/env_setup/devprereqs.sh
sh /tmp/env_setup/devprereqs.sh

wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/mongodb.sh -O /tmp/env_setup/mongodb.sh
sh /tmp/env_setup/mongodb.sh

wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/samba.sh -O /tmp/env_setup/samba.sh
sh /tmp/env_setup/samba.sh $password

wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/freetds.sh -O /tmp/env_setup/freetds.sh
sh /tmp/env_setup/freetds.sh

wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/webmin.sh -O /tmp/env_setup/webmin.sh
sh /tmp/env_setup/webmin.sh

wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/rabbitmq.sh -O /tmp/env_setup/rabbitmq.sh
sh /tmp/env_setup/rabbitmq.sh

rm -rf /tmp/env_setup/

EOF
