#!/bin/bash

ENV_DIR="/mnt/nas/bocchi/env"
ENV=$1

if [ $# -ne 1 ]; then
    exit
fi

if [ $ENV = "prod" ]; then
    USER="midas"
elif [ $ENV = "stag" ]; then
    USER="midas_stag"
else
    exit
fi

read -sp "password: " PASSWORD
echo ""

sudo mkdir -p /mnt/nas
sudo systemctl daemon-reload
sudo mount -t cifs //192.168.12.13/home /mnt/nas -o username=${USER},password=${PASSWORD},iocharset=utf8,rw

cp ${ENV_DIR}/cryptedEnv cryptedEnv
cp ${ENV_DIR}/cryptedSsl cryptedSsl

