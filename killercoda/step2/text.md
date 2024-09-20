

```md

1. **Add content to the application.yaml file**:
   Open the `argo-cd/application.yaml` file and add the following content:

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
       path: manifests/
     destination:
       server: https://kubernetes.default.svc
       namespace: default
     syncPolicy:
       automated:
         prune: true
         selfHeal: true

   ```


3. **Add content to the nginx-deployment.yaml**:
   Open the `manifests/nginx-deployment.yaml` file and add the following yaml file under config:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: FrontEndWebApp-deployment
     labels:
       app: FrontEndWebApp
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: FrontEndWebApp
     template:
       metadata:
         labels:
           app: FrontEndWebApp
       spec:
         containers:
         - name: FrontEndWebApp
           image: ArgoCD-Tutorial-Image:main
           ports:
           - containerPort: 80
   ```

4. **Add content to the nginx-service.yaml**:
   Open the `manifests/nginx-service.yaml` file and add the following:

   ```yaml

   apiVersion: v1
   kind: Service
   metadata:
     name: FrontEndWebApp-service 
   spec:
     selector:
       app: FrontEndWebApp
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
       
   ```

5. **Stage and push the changes**:
    After making the changes, stage and push the updates to your main branch

6. **Time to create a dev branch**:
    After making the changes, stage and push the updates to your main branch
    git checkout dev


    Now we need to modify some parameters to fit in to our dev pipe

    In `argo-cd/application.yaml` change targetRevision to dev
    ```yaml
   spec:
     project: default
     source:
       repoURL: https://github.com/<your-username>/<your-repo>.git
       targetRevision: dev
       .
       .
       .
   ```

   Modify the manifest file `manifests/nginx-deployment.yaml` to target your development image
    ```yaml 
   metadata:
     name: FrontEndWebApp-development
     labels:
       app: FrontEndWebApp
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: FrontEndWebApp
     template:
       metadata:
         labels:
           app: FrontEndWebApp
       spec:
         containers:
         - name: FrontEndWebApp
           image: ArgoCD-Tutorial-Image:dev
           ports:
           - containerPort: 80


-**>>>>>>>>>>>>>>>>>>>NOTE<<<<<<<<<<<<<<<<<<<<<**
Make sure that you have images with distinct tags for your two branches, one for development and one for stable deployments

  (F) These can be easiely created by running:
   
   ```bash
    docker build -t <docker-hub-username>/ArgoCD-Tutorial-Image:main
    docker build -t <docker-hub-username>/ArgoCD-Tutorial-Image:dev
    docker push <docker-hub-username>/ArgoCD-Tutorial-Image:main
    docker push <docker-hub-username>/ArgoCD-Tutorial-Image:dev
   ```
```
