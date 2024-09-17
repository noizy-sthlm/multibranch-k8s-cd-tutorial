
```md
## Step 3: Deploy the Pipelines

Now that the Argo CD applications are ready, deploy them.

1. Apply the Argo CD application manifests:

   ```bash
   kubectl apply -f argo-cd/application-main.yaml
   kubectl apply -f argo-cd/application-dev.yaml
   ```

2. Check the Argo CD dashboard at [Argo CD URL] and observe the pipelines syncing.

Once the pipelines are deployed, click **Finish** to complete the tutorial.
```

### Content of `finish.md`

```md
## Congratulations!

You have successfully set up two continuous deployment pipelines with Argo CD for `main` and `dev` branches. Check the Argo CD UI to observe changes being synced automatically from your GitHub repository to your Kubernetes cluster.
```