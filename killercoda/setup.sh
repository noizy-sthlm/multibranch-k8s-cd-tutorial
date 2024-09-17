#!/bin/bash

# Update and install dependencies
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl git apt-transport-https ca-certificates gnupg lsb-release

# Install Docker
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Install Minikube (or k3s if preferred)
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --driver=none

# Verify Kubernetes is running
kubectl get nodes

# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD to finish installing
kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd

# Forward the Argo CD server port so it's accessible at localhost:8080
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
