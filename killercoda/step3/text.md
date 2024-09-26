# Apply the configurations in ArgoCD
Now that you have the manifest files in place, it's time to apply them to Argo CD.

## Deploy the production web-app
We'll first deploy the production web-app. Grab the url to the application.yaml file in raw format (in your `main` branch) and execute the following command in this virtual-machine:
```bash
kubectl apply -f <URL-to-your-application.yaml> -n argocd
```
> ### Get the url for the raw application.yaml file
>Assuming that you are hosting your repository on github, you can navigate to argo-cd/application.yaml (on your 'main' branch) and click "raw" and copy the url
><img src="./gitRawLink.png" style="width: 700px">

Our production application should (soon) be up and running. Invoke `kubectl` to see for yourself:
```bash
kubectl get deployments -n dummy-webapp-deployment
```

Now, do the same but for our development branch. Just copy the link for `application.yaml` from your development branch and use the same commands to deploy.

## Access the dummy-webapp
- Port forward
- Access the python web-app