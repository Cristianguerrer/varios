#!/bin/bash

set -e

echo "📦 Instalando Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

echo "🚀 Iniciando Minikube con 1 control-plane y 1 worker (RAM: 1800MB)..."
minikube start --nodes=2 --cpus=2 --memory=1800 --driver=docker


echo "📦 Instalando ngrok..."
curl -LO https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xvzf ngrok-v3-stable-linux-amd64.tgz
sudo mv ngrok /usr/local/bin
rm ngrok-v3-stable-linux-amd64.tgz
ngrok config add-authtoken $YOUR_AUTHTOKEN

echo "✅ Verificando nodos:"
kubectl get nodes


#kubectl port-forward service/nginx 8080:80
#ngrok http 8080