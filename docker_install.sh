#!/bin/bash
set -e

curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker "$USER"
sudo systemctl enable --now docker

docker --version
docker compose version