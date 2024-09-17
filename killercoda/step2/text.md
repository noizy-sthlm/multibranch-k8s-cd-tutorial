
```md
## Step 2: Prepare Your Repository

In this step, you will create the necessary directories and files for the Argo CD setup.

### Instructions:
1. First, navigate to your repository directory:
   ```bash
   cd ~/your_repo
   ```

2. Create two directories: `argo-cd` and `manifests` to store Argo CD and Kubernetes manifest files.
   ```bash
   mkdir argo-cd manifests
   ```

3. Inside the `argo-cd` directory, create a file named `application.yaml`:
   ```bash
   touch argo-cd/application.yaml
   ```

4. Open the file in a text editor and add the following content:
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

5. Similarly, create another file for the `development` branch:
   ```bash
   touch argo-cd/application-dev.yaml
   ```

6. Open the `application-dev.yaml` file and add the following content:
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

7. Finally, in the `manifests` directory, create the Kubernetes manifest files for a basic NGINX deployment:
   ```bash
   touch manifests/nginx-deployment.yaml
   touch manifests/nginx-service.yaml
   ```

8. Add the following content to `nginx-deployment.yaml`:
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

9. Add the following content to `nginx-service.yaml`:
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