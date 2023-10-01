#!/bin/bash

source ../.env

openssl aes-256-cbc -e -pbkdf2 -iter 100000 -salt -in ../.env -out cryptedEnv -pass pass:${ENCRYPTION_KEY}
