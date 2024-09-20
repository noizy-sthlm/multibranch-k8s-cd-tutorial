3. **Step 3: Apply the Pipelines in Argo CD**

Now that you have created the necessary files in your repository, it's time to apply the pipelines to Argo CD.

### Instructions:

1. **Navigate to the `argo-cd` directory**:
   Use the terminal to navigate into the `argo-cd` directory in your repository:

   ```bash
   cd argo-cd
   ```

2. **Apply the `application.yaml` file for the main branch**:
   Apply the Argo CD configuration for the main branch by running the following command (Make sure that you have checked out to your dev branch):

   ```bash
   kubectl apply -f application.yaml
   ```

   This command will create the Argo CD application for the stable deployment branch.
**To deploy your stable application checkout to your main branch and run the same command**


4. **Verify that the applications have been created**:
   After applying the configurations, verify that the applications have been created by running:

   ```bash
   kubectl get applications -n argocd
   ```

   You should see both the `multi-branch-pipeline-main` and `multi-branch-pipeline-dev` applications listed.

5. **Monitor the sync status in Argo CD**:
   Go to the Argo CD dashboard to view the sync status of your applications. Argo CD will automatically sync with the manifests in your GitHub repository and apply any changes.

Once the pipelines have been applied, proceed to the next step to log in to the Argo CD dashboard.
```
