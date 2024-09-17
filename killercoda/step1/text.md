```markdown

# Step 1: Access Argo CD


The environment is already set up with Kubernetes and Argo CD installed.


1. Run the following command to check the status of the Argo CD pods:

   ```bash

   kubectl get pods -n argocd

   ```


2. Argo CD is available on [https://localhost:8080](https://localhost:8080).


3. Log in using the default credentials:

   - Username: `admin`

   - Password: Retrieve it using:

     ```bash

     kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | 
      ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) };

     ```





