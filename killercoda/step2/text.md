# The configuration
Following, we will configure a dummy web-app, nothing too complex.


## 1. application.yaml
In the `argo-cd/application.yaml` file, add the following configuration:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: dummy-webapp-production   #Name of the application
  namespace: argocd
spec:
  project: webapp                   #ArgoCD allows you to group applications into projects. The default is 'default'
  source:
    repoURL: https://github.com/<your-username>/<your-repo>.git  #Here we specify the our git repository that is publicly readable
    targetRevision: main #For now, we only have one branch. Later, we will set up the development branch as well
    path: manifests/ #We specify the path of our application configuration here
  destination:
    server: https://kubernetes.default.svc #We will use our local cluster but you could deploy on any cluster, eveb remote
    namespace: dummy-webapp-production #Any desired namespace for your deployment
  syncPolicy:    #Lets us specify how Argo CD should sync the actual state in our cluster with the desired state in the git repository
    automated:
      prune: true  #If we delete a component from the repository, Argo CD should delete it from the cluster as well
      selfHeal: true #Any manual changes (e.g., using cubectl) that do not reflect the desired state in our repo will be overwritten
```
As you see, ArgoCD applications are configured using the same yaml style configuration as kubernetes configs.

**!>Change spec.source.repoURL to a public repository of yours (you should have forked or created one in the previous step)!<**


## 2. webapp-deployment.yaml
Write the following configuration to `manifests/frontendwebapp-deployment.yaml`:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dummy-webapp
  labels:
    app: dummy-webapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: dummy-webapp
  template:
    metadata:
      labels:
        app: dummy-webapp
    spec:
      containers:
      - name: webapp
        image: noizysthlm/dummy-webapp:1.0
        ports:
        - containerPort: 80
```


## 3. webapp-service.yaml
Write to `manifests/webapp-service.yaml`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: dummy-webapp-service 
spec:
  selector:
    app: dummy-webapp
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8888

```

>**NOTE**
>For this tutorial, we have provided you with two images on Docker hub for you to use. If you would prefer however, you could edit the configuration to fit another image of your liking. You could also fork the application from ... and edit it to your liking and push it to your own image registry instead.

# A development branch
## 4. Time to create a dev branch
After we have completed the setup for our production branch we need to set up our development branch. This is where the developers will push new iterations of their application, to test in an isolated environment befor merging any changes with the main branch. It's not any more complex than a `git checkout -b dev` and a few tweaks of our configuration

Now we modify some parameters to fit in to our dev pipe

In `argo-cd/application.yaml` edit the application name,`spec.source.targetRevision`, and the target namespace `spec.destination.namespace`:
```yaml
metadata:
  name: dummy-webapp-development  #Here
  namespace: argocd
spec:
  project: webapp
  source:
    repoURL: https://github.com/<your-username>/<your-repo>.git
    targetRevisio: dev            #Here
    path: manifests/
  destination:
    server: https://kubernetes.default.svc
    namespace: dummy-webapp-development #Here
.
.
.
```

...and `targetPort` in `manifests/services/webapp-service.yaml`
```yaml
⫶
  - protocol: TCP
    port: 80
    targetPort: 9999  #This
```

**don't forget to push the changes to your repository**
