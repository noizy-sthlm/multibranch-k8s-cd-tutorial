# Prepare your repository

In this step, we will walk through the process of setting up a git repository with necessary configurationfiles for Argo CD and kubernetes.

Feeling lazy? We host an allready finnished repository on [https://github.com/noizy-sthlm/dummyWeb-ArgoCDk8s.git](https://github.com/noizy-sthlm/dummyWeb-ArgoCDk8s) Just fork and edit it to your liking.

## 1. Create a new GitHub repository
Initiate a public git repository. This is where we will host the configuration files for Argo CD and your Kubernetes application. Initially, we only need a "main" branch which we will refer to as "production".

## 2. Create necessary directories
In the repository, create the two directories `argo-cd` and `manifests`. The prior will be where we will store the ArgoCD configuration and the latter will be for the Kubernetes component configurations.
   
## 3. Create Argo CD application files
In the `argo-cd` directory, create a `application.yaml` file. This will be our application configuration for Argo CD.
>An application is just an Argo CD abstraction of a group of Kubernetes resources

## 4. Create Kubernetes manifest files
In this tutorial, we will set up a dummy web server consisting of one deployment, and one service.
Now, let’s create two Kubernetes manifests `webapp-deployment.yaml` and `webapp-service.yaml` inside the `manifests` directory:

Your repository should look like following:
```bash
dummyWeb-ArgoCDk8s/
├── argo-cd
│   └── application.yaml
└── manifests
    ├── webapp-deployment.yaml
    └── webapp-service.yaml

2 directories, 3 files
```


