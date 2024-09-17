# #!/bin/bash

# # Step 1: Create the Argo CD namespace
# kubectl create namespace argocd

# # Step 2: Install Argo CD
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# # Step 3: Wait for Argo CD components to be available
# kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server

# # Step 4: Patch Argo CD to allow insecure HTTP
# kubectl patch deploy argocd-server -n argocd --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--insecure"}]'

# # Step 5: Restart the Argo CD server to apply the changes
# kubectl rollout restart deploy argocd-server -n argocd

# # Step 6: Wait for Argo CD server to be fully ready again
# kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server

# # Step 7: Function to handle port-forwarding with retry
# port_forward() {
#   echo "Starting port-forwarding to expose Argo CD on http://localhost:8080"
#   while true; do
#     kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80
#     echo "Port-forwarding failed. Retrying in 5 seconds..."
#     sleep 5
#   done
# }

# # Start port-forwarding in the background and retry on failure
# port_forward &

# # Step 8: Wait for the Argo CD initial admin secret to be available
# while ! kubectl -n argocd get secret argocd-initial-admin-secret &>/dev/null; do
#     sleep 10
# done

# # Step 9: Retrieve the initial admin password for Argo CD
# admin_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)

# # Step 10: Display the login credentials to the user
# echo -e "\n\033[1mArgo CD is ready to use.\033[0m"
# echo -e "You can access the Argo CD UI at: \033[1mhttp://localhost:8080\033[0m"
# echo -e "Use the following credentials to log in:\n"
# echo -e "Username: \033[1madmin\033[0m"
# echo -e "Password: \033[1m$admin_password\033[0m"
# echo -e "\nKeep this terminal open to maintain the port-forwarding session.\n"

# # Keep the port-forward running by waiting on the background process
# wait


#!/bin/bash

# Step 1: Wait for the Argo CD server to be ready before starting any actions
sleep 15

echo "Waiting for Argo CD setup to complete..."
kubectl wait --for=condition=available --timeout=600s -n argocd deploy/argocd-server &>/dev/null

port_forward() {
  echo "Starting port-forwarding to expose Argo CD"
 while true; do
    kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80 
    echo "Port-forwarding failed. Retrying in 5 seconds..."
    sleep 2
  done
}

# Start port-forwarding in the background and retry on failure
port_forward &
clear
# Step 2: Wait for the Argo CD initial admin secret to be available
echo "Waiting for Argo CD admin password secret to be available..."
while ! kubectl -n argocd get secret argocd-initial-admin-secret &>/dev/null; do
    echo "Argo CD admin secret not found, waiting..."
    sleep 10
done

# Step 3: Retrieve the initial admin password for Argo CD
admin_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)

clear


# Step 4: Display the login credentials to the user
echo -e "\n\033[1mArgo CD is ready to use.\033[0m"
echo -e "You can access the Argo CD UI at: <session_id>-8080.spch.r.killercoda.com"
echo -e "Use the following credentials to log in:\n"
echo -e "Username: \033[1madmin\033[0m"
echo -e "Password: \033[1m$admin_password\033[0m"
echo -e "\nKeep this terminal open to maintain the port-forwarding session.\n"

# NOTE 
echo "############ refresh your browser tow or three times if the page does not load the first time ###############"

# Keep the port-forwarding running


wait

# refresh your browser tow or three times if the page does not load the first time

