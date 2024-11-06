#!/bin/bash

read -sp "restore key: " KEY

echo "decrypt env"
openssl aes-256-cbc -d -pbkdf2 -iter 100000 -salt -in secret/cryptedEnv -out .env -pass pass:${KEY}

echo "decrypt ssl"
openssl aes-256-cbc -d -pbkdf2 -iter 100000 -salt -in secret/cryptedSsl -out ssl.tar.gz -pass pass:${KEY}
tar -zxvf ssl.tar.gz
rm ssl.tar.gz

echo "image pull"
docker compose pull
echo "up rikka and yui"
docker compose up -d rikka yui

echo "sleep 30s"
sleep 30

echo "init query exec"
docker compose exec yui /docker-entrypoint-initdb.d/001_create_midas_uesr.sh
docker compose exec yui /docker-entrypoint-initdb.d/002_create_metabase.sh
docker compose exec yui /docker-entrypoint-initdb.d/003_create_backup_user.sh

echo "midas restore"
docker compose exec rikka /app/restore/crypt_restore.sh
echo "metabase restore"
docker compose exec rikka /app/restore/crypt_metabase_restore.sh

echo "up all"
docker compose up -d
