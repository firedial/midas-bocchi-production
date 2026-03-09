#!/bin/bash

# ssh allow from
read -p "ssh allow from: " ipAddress

# allow
echo "add allow"
echo "ALL: 127.0.0.1" >> /etc/hosts.allow
echo "sshd: $ipAddress" >> /etc/hosts.allow

# deny
echo "add deny"
echo "ALL:ALL" >> /etc/hosts.deny

# deny root login
echo "deny root login"
sed -i '/PermitRootLogin/d' /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

echo "restart"
systemctl restart sshd
