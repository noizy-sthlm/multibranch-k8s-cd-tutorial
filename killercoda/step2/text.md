# The configuration
You will write some manifests for your applications.

## 1. application.yaml
In the `argo-cd/application.yaml`{{}} file, write the following:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: dummy-webapp-production
  namespace: argocd
  annotations:
    argocd-image-updater.argoproj.io/image-list: webapp=noizysthlm/dummy-webapp:prod  #Change to the production image that you pushed before
    argocd-image-updater.argoproj.io/update-strategy: digest
    argocd-image-updater.argoproj.io/write-back-method: git
spec:
  project: default
  source:
    repoURL: https://github.com/noizy-sthlm/dummyWeb-ArgoCDk8s.git  #Change to your repository
    targetRevision: main
    path: manifests/
  destination:
    server: https://kubernetes.default.svc
    namespace: dummy-webapp-production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
    - CreateNamespace=true
```{{copy}}

***Note that you have to edit the file to your fit where there are comments***

Some fields of interest here are `spec.source.repoURL`{{}} which is where you host this repository. Once set up, Argo CD will watch it for any commits that you push and apply them to your cluster. `spec.syncPolicy.selfHeal: true`{{}} tells argoCD to revert any manual changes made to the cluster (e.g., using `kubectl`{{}}) which do not match the manifest (the desired state) in the repository. Moreover, the fields under `metadata.annotations`{{}} tell argocd-image-updater to watch for the latest build of your image with the `:prod`{{}} tag. If any such are found, it will edit the deployment manifest (using Kustomize) and write back to your origin repository. This will in turn trigger Argo CD to redeploy the application with the latest image.



## 2. webapp-deployment.yaml
Write the following configuration to `manifests/webapp-deployment.yaml`:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dummy-webapp-deployment
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
        image: noizysthlm/dummy-webapp:prod   #Change to your image
        ports:
        - containerPort: 5000
```{{copy}}

***Note that you have to edit the file to your fit where there are comments***

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
    port: 8888
    targetPort: 5000
```{{copy}}

## 4. kustomization.yaml
And to `manifests/kustomization.yaml`:
```yaml
resources:
  - webapp-deployment.yaml
  - webapp-service.yaml

images:
  - name: noizysthlm/dummy-webapp #Change to your image name
    newTag: "prod"
```{{copy}}

***Note that you have to edit the file to your fit where there are comments**

**Don't forget to commit and push the changes to your repository**

# A development branch
And so we need to set up our development branch.

## 1. Time to create a dev branch
After we have written the manifests for our production branch we need to set up our development branch. This is where the developers will push new iterations of their application, to test in an isolated environment befor merging any changes with the main branch. It's not more complex than a `git checkout -b dev`{{}} and a few tweaks of our the manifests.

## 2. application.yaml
In `argo-cd/application.yaml`{{}} edit the fields that are commented:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: dummy-webapp-development    #This differs from the production branch
  namespace: argocd
  annotations:
    argocd-image-updater.argoproj.io/image-list: webapp=noizysthlm/dummy-webapp:dev  #Differs for each user and branch
    argocd-image-updater.argoproj.io/update-strategy: digest
    argocd-image-updater.argoproj.io/write-back-method: git
spec:
  project: default
  source:
    repoURL: https://github.com/noizy-sthlm/dummyWeb-ArgoCDk8s.git
    targetRevision: dev   #This differs from the production branch
    path: manifests/
  destination:
    server: https://kubernetes.default.svc
    namespace: dummy-webapp-development   #This differs from the production branch
.
.
.
```

## 3. kustomization.yaml
Also, we need to edit `manifests/kustomization.yaml`{{}}

```yaml
...
images:
  - name: noizysthlm/dummy-webapp   #Should be your image name
    newTag: "dev"                   #This differs from the production branch
```

Finally, **don't forget to commit and push the changes to your repository**
