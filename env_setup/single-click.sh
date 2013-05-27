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

echo "--------Starting setup"

echo "--------Installing wget"
yum install wget -y

echo "--------Create and change to tmp folder for setups"
mkdir -p /tmp/env_setup
cd /tmp/env_setup

echo "--------Create the development user"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/createuser.sh -O /tmp/env_setup/createuser.sh
sh /tmp/env_setup/createuser.sh $user_name $password

echo "--------Disable SELinux and flush the IPTables"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/firewall.sh -O /tmp/env_setup/firewall.sh
sh /tmp/env_setup/firewall.sh

echo "--------Install development prerequisites"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/devprereqs.sh -O /tmp/env_setup/devprereqs.sh
sh /tmp/env_setup/devprereqs.sh

echo "--------Install Node.js"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/node.sh -O /tmp/env_setup/node.sh
sh /tmp/env_setup/node.sh

echo "--------Install MongoDB"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/mongodb.sh -O /tmp/env_setup/mongodb.sh
sh /tmp/env_setup/mongodb.sh

echo "--------Install Samba and set up the development share"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/samba.sh -O /tmp/env_setup/samba.sh
sh /tmp/env_setup/samba.sh $password

echo "--------Install FreeTDS for SQL Server access"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/freetds.sh -O /tmp/env_setup/freetds.sh
sh /tmp/env_setup/freetds.sh


echo "--------Install the Webmin admin server"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/webmin.sh -O /tmp/env_setup/webmin.sh
sh /tmp/env_setup/webmin.sh

echo "--------Install RabbitMQ"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/rabbitmq.sh -O /tmp/env_setup/rabbitmq.sh
sh /tmp/env_setup/rabbitmq.sh

echo "--------Install RVM, Ruby, and Rails"
wget https://raw.github.com/MikeLindeMoveInc/scripts/master/env_setup/rvm.sh -O /tmp/env_setup/rvm.sh
sh /tmp/env_setup/rvm.sh
source usr/local/rvm/scripts/rvm
rvm install 1.9.3

echo "--------Remove the temporary folder"
cd ~
rm -rf /tmp/env_setup/

EOF

echo "--------Setup complete"
