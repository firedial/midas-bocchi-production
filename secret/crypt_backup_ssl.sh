#!/bin/bash

read -sp "restore key: " KEY

tar -zcvf ssl.tar.gz ../ssl
openssl aes-256-cbc -e -pbkdf2 -iter 100000 -salt -in ssl.tar.gz -out cryptedSsl -pass pass:${KEY}
rm ssl.tar.gz
