Here’s the entire **Step 2** properly formatted for you:

```md
## Step 2: Prepare Your Repository

In this step, you will create the necessary directories and files for the Argo CD setup.

### Instructions:

1. **Navigate to your repository**:
   First, navigate to the root directory of your cloned repository:
   ```bash
   cd <your-repo>
   ```

2. **Create the directories**:
   Create two directories: `argo-cd` and `manifests` to store Argo CD and Kubernetes manifest files:
   ```bash
   mkdir argo-cd manifests
   ```

3. **Create Argo CD application file for the main branch**:
   Inside the `argo-cd` directory, create a file named `application.yaml`:
   ```bash
   touch argo-cd/application.yaml
   ```

4. **Add content to the application.yaml file**:
   Open the `application.yaml` file and add the following content:
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: multi-branch-pipeline
     namespace: argocd
   spec:
     project: default
     source:
       repoURL: https://github.com/<your-username>/<your-repo>.git
       targetRevision: main
       path: manifests
     destination:
       server: https://kubernetes.default.svc
       namespace: default
     syncPolicy:
       automated:
         prune: true
         selfHeal: true
   ```

5. **Create Argo CD application file for the development branch**:
   Similarly, create another file named `application-dev.yaml`:
   ```bash
   touch argo-cd/application-dev.yaml
   ```

6. **Add content to the application-dev.yaml file**:
   Open the `application-dev.yaml` file and add the following content:
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: multi-branch-pipeline-dev
     namespace: argocd
   spec:
     project: default
     source:
       repoURL: https://github.com/<your-username>/<your-repo>.git
       targetRevision: development
       path: manifests
     destination:
       server: https://kubernetes.default.svc
       namespace: default
     syncPolicy:
       automated:
         prune: true
         selfHeal: true
   ```

7. **Create Kubernetes manifest files**:
   Now, in the `manifests` directory, create the Kubernetes manifest files for a basic NGINX deployment:
   ```bash
   touch manifests/nginx-deployment.yaml
   touch manifests/nginx-service.yaml
   ```

8. **Add content to the nginx-deployment.yaml**:
   Open the `nginx-deployment.yaml` file and add the following:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx-deployment
     labels:
       app: nginx
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: nginx
     template:
       metadata:
         labels:
           app: nginx
       spec:
         containers:
         - name: nginx
           image: nginx:1.14.2
           ports:
           - containerPort: 80
   ```

9. **Add content to the nginx-service.yaml**:
   Open the `nginx-service.yaml` file and add the following:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: nginx-service
   spec:
     selector:
       app: nginx
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
   ```

10. **Stage and push the changes**:
    After making the changes, stage and push the updates to your GitHub repository:
    ```bash
    git add .
    git commit -m "Added Argo CD configuration and NGINX manifests"
    git push origin main
    ```
```
