#!/bin/bash
set -e

# Install Docker if missing
if ! command -v docker >/dev/null 2>&1; then
    yum update -y
    amazon-linux-extras install docker -y
    systemctl start docker
    systemctl enable docker
fi

# Install Docker Compose if missing
if ! command -v docker-compose >/dev/null 2>&1; then
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

mkdir -p /opt/n8n
cat <<'EOC' > /opt/n8n/docker-compose.yml
version: '3'
services:
  n8n:
    image: n8nio/n8n
    restart: always
    ports:
      - "80:5678"
    volumes:
      - n8n_data:/home/node/.n8n
volumes:
  n8n_data:
EOC

cd /opt/n8n
/usr/local/bin/docker-compose up -d
