#!/bin/bash

# Setting up Argo CD in the background
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD pods to start
echo "Waiting for Argo CD pods to be ready..."
kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server
kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-applicationset-controller

# Restart the Argo CD server to apply the changes
echo "Restarting Argo CD server..."
kubectl rollout restart deploy argocd-server -n argocd

# Wait for Argo CD to restart and be ready
echo "Waiting for Argo CD server to restart..."
kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server
