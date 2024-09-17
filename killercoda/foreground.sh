#!/bin/bash

# Notify the user that the environment is being set up
echo "Setting up your environment... Please wait, this may take a few minutes."

# Check if Argo CD is ready
while ! kubectl get pods -n argocd | grep -q 'argocd-server.*Running'; do
    echo "Waiting for Argo CD to be fully up..."
    sleep 10
done

# Final message to the user
echo "Argo CD is ready! You can access it at https://localhost:8080"
echo "Run the following command to retrieve the admin password:"
echo "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | 
      ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) };"
