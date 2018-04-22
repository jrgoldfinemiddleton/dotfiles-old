#!/bin/sh

CURUSER=$(whoami)

if [ $CURUSER != 'root' ]; then
    return 1
fi

apt-get update
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

return 0
