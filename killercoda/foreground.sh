#!/bin/bash

# Step 1: Wait for the Argo CD server to be ready before starting any actions
clear
echo "Waiting for Argo CD server to be ready..."
sleep 15

echo "Waiting for Argo CD setup to complete..."
kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server &>/dev/null

# Step 2: Function to handle port-forwarding with retries and termination of previous processes
port_forward() {
  echo "Starting port-forwarding to expose Argo CD"
  while true; do
    # Kill any previous port-forwarding processes on port 8080
    kill -9 $(lsof -t -i:8080) &>/dev/null || true
    
    # Start port-forwarding and wait for it to succeed
    kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80 &>/dev/null
    echo "Port-forwarding failed. Retrying in 5 seconds..."
    sleep 5
  done
}

# Start port-forwarding in the background and retry on failure
port_forward &

clear

# Step 3: Wait for the Argo CD initial admin secret to be available
echo "Waiting for Argo CD admin password secret to be available..."
while ! kubectl -n argocd get secret argocd-initial-admin-secret &>/dev/null; do
    echo "Argo CD admin secret not found, waiting..."
    sleep 10
done

# Step 4: Retrieve the initial admin password for Argo CD
admin_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)

clear

# Step 5: Display the login credentials to the user
echo -e "\n\033[1mArgo CD is ready to use.\033[0m"
echo -e "You can access the Argo CD UI at: <session_id>-8080.spch.r.killercoda.com"
echo -e "Use the following credentials to log in:\n"
echo -e "Username: \033[1madmin\033[0m"
echo -e "Password: \033[1m$admin_password\033[0m"
echo -e "\nKeep this terminal open to maintain the port-forwarding session.\n"

# NOTE: Tell the user to refresh the browser if it does not load right away
echo "############ Refresh your browser two or three times if the page does not load the first time ###############"

# Keep the port-forwarding running in the background
wait &

# let the user know the script has ended
echo "Now you can use the terminal for other tasks."


