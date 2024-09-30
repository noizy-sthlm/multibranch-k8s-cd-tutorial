# Prepare your repository

In this step, we will walk you through the process of setting up a git repository with necessary manifests for Argo CD and Kubernetes. We recommend that you create your repository as well as all of the manifests from your host instead of inside this virtual machine.

Feeling lazy? We host a template on [https://github.com/noizy-sthlm/dummyWeb-ArgoCDk8s.git](https://github.com/noizy-sthlm/dummyWeb-ArgoCDk8s) Just fork and edit it to your fit.

## 1. Create a new GitHub repository
Initiate a public git repository (, or fork our template). This is where you will host the manifests for your Argo CD applications and your Kubernetes components. For now, we only need a "main" branch which we will use as our "production" branch. This is where you will deploy your application for production. 

## 2. The directories
In the repository, create the two directories `argo-cd` and `manifests`{{}}. The prior will be where you will store the application manifest for ArgoCD and the latter for your Kubernetes components.
   
## 3. Argo CD application manifest
In the `argo-cd`{{}} directory, create a `application.yaml`{{}} file.

## 4. Create Kubernetes manifest files
In this scenario, you will set up a dummy web server consisting of one deployment, and one service. Therefore, let’s create the manifests `webapp-deployment.yaml`{{}}, `webapp-service.yaml`{{}}, and `kustomization.yaml`{{}} in the `manifests/`{{}} directory.

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
Before proceeding, you should prepare two web-app container image builds and push them to your Docker hub repository. These will be what you will use in your deployments during later steps.

### 5a. Clone the python server and edit the code
The Github repository [noizy-sthlm/dummy-webapp](https://github.com/noizy-sthlm/dummy-webapp) contains code that you can use to build your image. Just clone it (**but not in to the repository you just created**) and edit the string that it prints. It could be something representing the version of your web-app:

```python
@app.route('/')
def hello():
    return ":production web v1.0 " #This string will be printed
```

### 5b Build and push the "production" image to Docker Hub
Once you have edited the string to fit your production website, build and push the image to Docker Hub:

```bash
docker build -t <your-namespace/>/dummy-webapp:prod .
docker push <your-namespace/>/dummy-webapp:prod
```

Don't forget to sign in to Docker crom your command line first
Note that we use the :prod tag for production builds of the image.

### 5c Build and push the development image to the Docker Hub
For our development build of the image, choose another string, e.g. `"development web 1.0"`{{}}, build and push with the `:dev`{{}} tag:

```bash
docker build -t <your-namespace/>dummy-webapp:dev .
docker push <your-namespace/>dummy-webapp:dev
```
