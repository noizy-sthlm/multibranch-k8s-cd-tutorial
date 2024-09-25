## Access the dummy-webapp
## Modify the K8s manifests and see how ArgoCD automaticaly syncs

Click **Finish** when you're done to complete the tutorial.
```

(!!!ArgoCD polls the git repo every 3 minutes!!)
Immediate sync requires webhooks

For image updater
kubectl logs -n argocd deployment/argocd-image-updater

