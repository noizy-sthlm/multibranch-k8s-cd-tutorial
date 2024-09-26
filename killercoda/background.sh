#!/bin/bash

# Step 1: Create the Argo CD namespace
kubectl create namespace argocd &>/dev/null

# Step 2: Install Argo CD (silent)
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml &>/dev/null

# Step 3: Wait for Argo CD components to be available (silent)
kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server &>/dev/null

# Step 4: Patch Argo CD to allow insecure HTTP (silent)
kubectl patch deploy argocd-server -n argocd --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--insecure"}]' &>/dev/null

# Step 5: Restart the Argo CD server to apply the changes (silent)
kubectl rollout restart deploy argocd-server -n argocd &>/dev/null

# Step 6: Wait for Argo CD server to be fully ready again (silent)
kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server &>/dev/null

# argocd-image-updater
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml



