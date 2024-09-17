#!/bin/bash

# Step 1: Update and install basic dependencies
sudo apt-get update && sudo apt-get install -y curl git apt-transport-https ca-certificates gnupg lsb-release docker.io

# Step 2: Install Minikube (this will allow you to run Kubernetes locally)
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Step 3: Start Minikube (this starts the Kubernetes cluster)
minikube start --driver=none

# Step 4: Install `kubectl` (the Kubernetes command-line tool)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Step 5: Verify Kubernetes is running
kubectl get nodes

# Step 6: Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Step 7: Wait for Argo CD to be ready
while ! kubectl get pods -n argocd | grep -q 'argocd-server.*Running'; do
    echo "Waiting for Argo CD to be fully up..."
    sleep 10
done

# Step 8: Port-forward Argo CD to port 8080
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
echo "Argo CD is ready! Access it at https://localhost:8080"
