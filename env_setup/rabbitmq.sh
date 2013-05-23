#! /bin/bash

# Run as root
ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Must be root to run this script."
  exit
fi

yum install erlang -y

cd /tmp/env_setup
wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.1/rabbitmq-server-3.1.1-1.noarch.rpm
rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
yum install rabbitmq-server-3.1.1-1.noarch.rpm -y
chkconfig rabbitmq-server on

service rabbitmq-server start
rabbitmq-plugins enable rabbitmq-management
service rabbitmq-server restart
