
### 4. **Verification Script (`step1/verify.sh`)**

Here’s the script to verify if the environment is working properly:

```bash
#!/bin/bash

# Check if Kubernetes is running
kubectl get nodes | grep -q 'Ready'
if [ $? -ne 0 ]; then
  echo "Kubernetes is not running properly."
  exit 1
fi

# Check if Argo CD is installed
kubectl get pods -n argocd | grep -q 'argocd-server'
if [ $? -ne 0 ]; then
  echo "Argo CD server is not installed properly."
  exit 1
fi

echo "Kubernetes and Argo CD are running successfully."
