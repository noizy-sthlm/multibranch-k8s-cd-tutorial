#!/bin/bash

# Port-forward to expose the Argo CD server
echo "Port-forwarding Argo CD on http://localhost:8080"
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80 &

# Wait a bit for port-forwarding to be established
sleep 5

# Retrieve the initial admin password for Argo CD
echo "Retrieving Argo CD admin password:"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
