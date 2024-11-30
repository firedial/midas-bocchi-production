#!/bin/bash

ENV_DIR="/mnt/nas/bocchi/env"

read -sp "restore key: " KEY
openssl aes-256-cbc -e -pbkdf2 -iter 100000 -salt -in .env -out cryptedEnv -pass pass:${KEY}

mv cryptedEnv ${ENV_DIR}/cryptedEnv
