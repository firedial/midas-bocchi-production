#!/bin/bash

source ../.env

tar -zcvf ssl.tar.gz ../ssl
openssl aes-256-cbc -e -pbkdf2 -iter 100000 -salt -in ssl.tar.gz -out cryptedSsl -pass pass:${ENCRYPTION_KEY}
rm ssl.tar.gz
