

```md
## Step 2: Create Argo CD Applications

Now, you will create Argo CD applications for both `main` and `dev` branches.

1. Inside the repository, create a directory named `argo-cd`:

   ```bash
   mkdir -p argo-cd
   ```

2. Inside the `argo-cd` directory, create two YAML files: `application-main.yaml` and `application-dev.yaml`:

#### application-main.yaml

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: main-pipeline
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/YOUR_USERNAME/YOUR_REPO.git
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

#### application-dev.yaml

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: dev-pipeline
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/YOUR_USERNAME/YOUR_REPO.git
    targetRevision: dev
    path: manifests
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Push these changes to your repository:

```bash
git add .
git commit -m "Added Argo CD applications"
git push origin main
```

Once you've pushed the changes, click **Next**.