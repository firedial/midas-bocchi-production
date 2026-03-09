#!/bin/bash

read -sp "restore key: " KEY
openssl aes-256-cbc -e -pbkdf2 -iter 100000 -salt -in .env -out cryptedEnv -pass pass:${KEY}

echo "----------------------------------------"
base64 -w 0 cryptedEnv
echo
echo "----------------------------------------"

rm cryptedEnv
