#!/bin/bash

# Inform the user that the script is setting up Argo CD and waiting for it to be ready
echo "Setting up Argo CD and waiting for all components to be ready. This may take a few minutes..."

# Wait for the Argo CD server service to be available
echo "Waiting for the Argo CD server service to be available..."
while ! kubectl get svc argocd-server -n argocd &>/dev/null; do
    echo "Argo CD server service not found, waiting..."
    sleep 10
done

# Port-forward to expose the Argo CD server
echo "Port-forwarding Argo CD on http://localhost:8080"
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80 &
port_forward_pid=$!

# Wait for a bit for the port-forward to be established
sleep 5

# Wait for the Argo CD initial admin secret to be available
echo "Waiting for the Argo CD admin password secret to be available..."
while ! kubectl -n argocd get secret argocd-initial-admin-secret &>/dev/null; do
    echo "Argo CD admin secret not found, waiting..."
    sleep 10
done

# Retrieve the initial admin password for Argo CD
echo "Retrieving Argo CD admin password..."
admin_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)

# Display the login credentials to the user
echo -e "\n\033[1mArgo CD is ready to use.\033[0m"
echo -e "You can access the Argo CD UI at: \033[1mhttp://localhost:8080\033[0m"
echo -e "Use the following credentials to log in:\n"
echo -e "Username: \033[1madmin\033[0m"
echo -e "Password: \033[1m$admin_password\033[0m"
echo -e "\nKeep this terminal open to maintain the port-forwarding session.\n"

# Keep the port-forwarding running
wait $port_forward_pid
