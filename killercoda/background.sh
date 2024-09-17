#!/bin/bash

# Setting up Argo CD in the background
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD to start
sleep 60

# Patch Argo CD to allow insecure HTTP
kubectl patch deploy argocd-server -n argocd --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--insecure"}]'

# Restart the Argo CD server
kubectl rollout restart deploy argocd-server -n argocd

# Sleep to ensure Argo CD is up and running
sleep 30
