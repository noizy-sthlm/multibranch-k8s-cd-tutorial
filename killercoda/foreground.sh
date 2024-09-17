#!/bin/bash

# Wait for the Argo CD server service to be available
echo "Waiting for Argo CD server service to be available..."
while ! kubectl get svc argocd-server -n argocd &>/dev/null; do
    echo "Argo CD server service not found, waiting..."
    sleep 10
done



# Wait a bit for port-forwarding to be established
sleep 5

# Wait for the Argo CD initial admin secret to be available
echo "Waiting for the Argo CD admin password secret to be available..."
while ! kubectl -n argocd get secret argocd-initial-admin-secret &>/dev/null; do
    echo "Argo CD admin secret not found, waiting..."
    sleep 10
done

# Retrieve the initial admin password for Argo CD
echo "Retrieving Argo CD admin password:"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode


# Patch Argo CD to allow insecure HTTP
echo "Patching Argo CD to allow insecure HTTP..."
kubectl patch deploy argocd-server -n argocd --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--insecure"}]'

# Port-forward to expose the Argo CD server
echo "Port-forwarding Argo CD server..."
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80 &

# Wait a bit for port-forwarding to be established
sleep 5

echo "Argo CD server is now available 
