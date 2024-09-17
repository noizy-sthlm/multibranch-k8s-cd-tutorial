#!/bin/bash

# Create namespace and install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD to be fully deployed
sleep 60

# Patch the Argo CD deployment to allow insecure HTTP access
kubectl patch deploy argocd-server -n argocd --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--insecure"}]'

# Restart the Argo CD deployment to apply the changes
kubectl rollout restart deploy argocd-server -n argocd

# Wait for Argo CD to be fully up
sleep 30
