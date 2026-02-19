#!/bin/bash

# ssh public key
read -p "ssh public key: " publicKey
echo "$publicKey" >> ~/.ssh/authorized_keys

# ssh allow from
read -p "ssh allow from: " ipAddress

# allow
echo "ALL: 127.0.0.1" >> /etc/hosts.allow
echo "sshd: $ipAddress" >> /etc/hosts.allow

# deny
echo "ALL:ALL" >> /etc/hosts.deny

# deny password login
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# deny root login
sed '/PermitRootLogin/d' /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

systemctl restart sshd
