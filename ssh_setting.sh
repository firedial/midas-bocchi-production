#!/bin/bash

# ssh allow from
read -p "ssh allow from: " ipAddress

# allow
echo "ALL: 127.0.0.1" >> /etc/hosts.allow
echo "sshd: $ipAddress" >> /etc/hosts.allow

echo "cat allow"
echo "--------------------"
cat /etc/hosts.allow
echo "--------------------"
read tmp

# deny
echo "ALL:ALL" >> /etc/hosts.deny

echo "cat deny"
echo "--------------------"
cat /etc/hosts.deny
echo "--------------------"
read tmp

# deny root login
sed -i '/PermitRootLogin/d' /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

echo "cat config"
echo "--------------------"
cat /etc/ssh/sshd_config
echo "--------------------"
read tmp

systemctl restart sshd
