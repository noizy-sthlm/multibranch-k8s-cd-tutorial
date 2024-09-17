#!/bin/bash

# Inform the user that the script is setting up Argo CD and waiting for it to be ready
echo "Setting up Argo CD in your environment. This may take a few minutes..."

# Step 1: Create the Argo CD namespace
kubectl create namespace argocd

# Step 2: Install Argo CD
echo "Installing Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Step 3: Wait for Argo CD components to be available
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

# Step 7: Port-forward to expose the Argo CD server
echo "Port-forwarding Argo CD on http://localhost:8080"
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80 &
port_forward_pid=$!

# Wait a bit for the port-forward to be established
sleep 5

# Step 8: Wait for the Argo CD initial admin secret to be available
echo "Waiting for Argo CD admin password secret to be available..."
while ! kubectl -n argocd get secret argocd-initial-admin-secret &>/dev/null; do
    echo "Argo CD admin secret not found, waiting..."
    sleep 10
done

# Step 9: Retrieve the initial admin password for Argo CD
echo "Retrieving Argo CD admin password..."
admin_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)

# Step 10: Display the login credentials to the user
echo -e "\n\033[1mArgo CD is ready to use.\033[0m"
echo -e "You can access the Argo CD UI at: \033[1mhttp://localhost:8080\033[0m"
echo -e "Use the following credentials to log in:\n"
echo -e "Username: \033[1madmin\033[0m"
echo -e "Password: \033[1m$admin_password\033[0m"
echo -e "\nKeep this terminal open to maintain the port-forwarding session.\n"

# Keep the port-forwarding running
wait $port_forward_pid
