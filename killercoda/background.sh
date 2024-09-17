#!/bin/bash

# Install Docker quietly
sudo apt-get update && sudo apt-get install -y docker.io >/dev/null 2>&1

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Install Minikube (Kubernetes)
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 >/dev/null 2>&1
sudo install minikube-linux-amd64 /usr/local/bin/minikube >/dev/null 2>&1

# Start Minikube
minikube start --driver=none >/dev/null 2>&1

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" >/dev/null 2>&1
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install Argo CD
kubectl create namespace argocd >/dev/null 2>&1
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml >/dev/null 2>&1

# Wait for Argo CD to finish installing
kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd >/dev/null 2>&1

# Start port-forwarding silently in the background
kubectl port-forward svc/argocd-server -n argocd 8080:443 >/dev/null 2>&1 &
