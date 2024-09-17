#!/bin/bash

# Step 1: Create the Argo CD namespace
kubectl create namespace argocd

# Step 2: Install Argo CD
echo "Installing Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Step 3: Wait for Argo CD server to be available
echo "Waiting for Argo CD server to be available..."
kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server

# Step 4: Patch Argo CD to allow insecure HTTP
echo "Patching Argo CD to allow insecure HTTP..."
kubectl patch deploy argocd-server -n argocd --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--insecure"}]'

# Step 5: Restart the Argo CD server to apply the changes
echo "Restarting Argo CD server to apply changes..."
kubectl rollout restart deploy argocd-server -n argocd

# Step 6: Wait for Argo CD server to be fully ready again
echo "Waiting for Argo CD server to be fully ready after the restart..."
kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server
