# Prepare your repository

In this step, we will walk through the process of setting up a git repository with necessary configurationfiles for Argo CD and Kubernetes.

Feeling lazy? We host an allready finnished repository on [https://github.com/noizy-sthlm/dummyWeb-ArgoCDk8s.git](https://github.com/noizy-sthlm/dummyWeb-ArgoCDk8s) Just fork and edit it to fit you.

## 1. Create a new GitHub repository
Initiate a public git repository. This is where we will host the configuration files for Argo CD and your Kubernetes application. Initially, we only need a "main" branch which we will refer to as "production".

## 2. Create necessary directories
In the repository, create the two directories `argo-cd` and `manifests`. The prior will be where we store the application manifest for ArgoCD and the latter for our Kubernetes manifests.
   
## 3. Create Argo CD application files
In the `argo-cd` directory, create a `application.yaml` file. This will be our application configuration for Argo CD.
>An application is just an Argo CD abstraction of a group of Kubernetes resources

## 4. Create Kubernetes manifest files
In this tutorial, we will set up a dummy web server consisting of one deployment, and one service.
Now, let’s create two Kubernetes manifests `webapp-deployment.yaml` and `webapp-service.yaml` inside the `manifests` directory as well as the `kustomization.yaml` file:

Your repository should have the following structure:
```bash
dummyWeb-ArgoCDk8s/
├── argo-cd
│   └── application.yaml
└── manifests
    ├── kustomization.yaml
    ├── webapp-deployment.yaml
    └── webapp-service.yaml

2 directories, 3 files
```

## 5. Prepare your webapp container images
Before going forward, you should prepare your webapp container image and push them to your public Docker hub registry.

### 5a. Clone the python server and edit the code
Clone/fork [dummy-webapp](https://github.com/noizy-sthlm/argo-cd-multibranch-pipeline). This repository contains a simple web-server that will print a simple message. You can edit the string in `app.py` to represent a version of your webapp:
```bash
@app.route('/')
def hello():
    return ":prod Image v1.0 "
```

### 5b Build and push the "production" image to Docker Hub
This will be our production webapp that you can now build and push to your Docker image registry:

```bash
docker build -t <your-docker-username>/dummy-webapp:prod
docker push <your-docker-username>/dummy-webapp:prod
```

### 5c Build and push the development image to the Docker Hub
Imaging that we want a development images with `:dev`, we can


```bash
docker build -t <your-docker-username>/dummy-webapp:dev
docker push <your-docker-username>/dummy-webapp:dev
```
