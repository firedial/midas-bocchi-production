#!/bin/bash

read -p "cryptedEnv: " cryptedEnv
echo $cryptedEnv | base64 -d > cryptedEnv

if [ $? -eq 1 ]; then
echo "wrong base64"
exit
fi

read -sp "restore key: " KEY

echo "decrypt env"
openssl aes-256-cbc -d -pbkdf2 -iter 100000 -salt -in cryptedEnv -out .env -pass pass:${KEY}

if [ $? -eq 1 ]; then
echo "wrong restore key"
exit
fi

rm cryptedEnv

echo "read .env"
while IFS='=' read -r key value; do
    [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue
    export "$key=$value"
done < .env

echo "restore ssl"
mkdir ssl
echo ${SSL_KEY} | base64 -d > ssl/server.key
echo ${SSL_CERT} | base64 -d > ssl/server.crt

echo "image pull"
docker compose pull
echo "up all"
docker compose up -d --wait

echo "midas restore"
docker compose exec rikka /app/restore/crypt_restore.sh
echo "metabase restore"
docker compose exec rikka /app/restore/crypt_metabase_restore.sh
