


1. **Add content to the application.yaml file**:

   Open the `argo-cd/application.yaml` file and add the following content:

   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: multi-branch-pipeline-main
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


2. **Add content to the nginx-deployment.yaml**:
   Open the `manifests/frontendwebapp-deployment.yaml` file and add the following yaml file under config:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: depfrontendwebapp
     labels:
       app: frontendwebapp
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: frontendwebapp
     template:
       metadata:
         labels:
           app: frontendwebapp
       spec:
         containers:
         - name: frontendwebapp
           image: <docker-hub-username>/argocd-tutorial-image-main
           ports:
           - containerPort: 80
   ```

3. **Add content to the nginx-service.yaml**:
   Open the `manifests/frontendwebapp-service.yaml` file and add the following:

   ```yaml

   apiVersion: v1
   kind: Service
   metadata:
     name: servicefrontendwebapp 
   spec:
     selector:
       app: frontendwebapp 
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
       
   ```


-**NOTE**

Make sure that you have images with distinct tags for your two branches, one for development and one for stable deployments

(F) These can be easiely created by running:
 ```bash
  nano Docker

  ```
  And then modify:

  ```bash
    # Use an official Ubuntu as a parent image
    FROM ubuntu:20.04

    # Set environment to non-interactive to prevent prompts
    ENV DEBIAN_FRONTEND=noninteractive

    # Install necessary tools including Python
    RUN apt-get update && apt-get install -y \
        python3 \
        python3-pip \
        git \
        curl \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

    # Copy the Python app into the container
    COPY app.py /usr/src/app/app.py

    # Set the working directory
    WORKDIR /usr/src/app

    # Set the command to run the Python app
    CMD ["python3", "app.py"]

  ```


Create your app.py 

 ```python
  # app.py 
  print("Hello, world!")

  ```


First you have to login by running:

  ```bash
  docker login 
  ```

  ```bash
  docker build -t <docker-hub-username>/argocd-tutorial-image-stable .
  docker build -t <docker-hub-username>/argocd-tutorial-image-dev .
  docker push <docker-hub-username>/argocd-tutorial-image-stable
  docker push <docker-hub-username>/argocd-tutorial-image-dev
  ```

4. **Stage and push the changes**:
    After making the changes, stage and push the updates to your main branch


5. **Time to create a dev branch**:
    After making the changes, stage and push the updates to your main branch
    ```bash
    git checkout -b dev
    ```

    Now we need to modify some parameters to fit in to our dev pipe

    In `argo-cd/application.yaml` change targetRevision, and multi-branch-pipeline-main to multi-branch-pipeline-dev to dev
    
    ```yaml
        metadata:
          name: multi-branch-pipeline-dev
          namespace: argocd
      spec:
        project: default
        source:
          repoURL: https://github.com/<your-username>/<your-repo>.git
          targetRevisio: dev
       .
       .
       .
    ```

   Modify the manifest file `manifests/frontendwebapp-deployment.yaml` to target your development image
    ```yaml 
   metadata:
     name: depfrontendwebapp
     labels:
       app: frontendwebapp 
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: frontendwebapp
     template:
       metadata:
         labels:
           app: frontendwebapp
       spec:
         containers:
         - name: frontendwebapp
           image: <docker-hub-username>/argocd-tutorial-image-dev
           ports:
           - containerPort: 80


6. **Dev branch**:
  After making the changes, stage and push the updates to your dev branch 


