# Argo CD Multi-Branch Pipeline Setup

### Authored by: [Sam Maltin](https://github.com/SMaltin93) & [Amin Nouiser](https://github.com/noizy-sthlm)

Welcome to this Argo CD scenario! Here, you'll learn how to set up and deploy a multi-branch continous deployment (CD) pipe for your Kubernetes projects using Argo CD. This schenario will walk you through configuring Argo CD with two branches for a web application: one for production and one for testing. After this tutorial, you'll have a basic understanding of what Argo CD is and how you can use it to manage manage a multi-branch CD pipe.

The finished product will include two deployments of a web application: one for production and one for testing. You will have configured Argo CD so that any new images that you push to your image repository are automatically deployed in your cluster. Any changes that you make to your Kubernetes manifests will also be recognized and automatically deployed by Argo CD.

### Prerequisites:
- You should have a basic skills in Git and Kubernetes.
- Docker Hub or equal to where you can push some public images
- Git service where you can host a public repository

Let's get started!!

>## What/Why Argo CD:
>Argo CD is a CD tool for Kubernetes. Its primary function is to keep the actual state of a cluster in sync with a desired state that a user has declared in their manifests. This is achieved by letting Argo CD poll a git repository where the clusters desired state is defined through K8s manifests. In a manual workflow, a developer that needs to re-deploy their applicagions have to invoke the `kubectl`{{}} command-line tool. However, this can become tedious if a team changes the manifests many times a day and have to spend half their time redeploying the application.
>
>With Argo CD, you no longer need to invoke `kubectl`{{}} after pushing changes to your repository, instead, you configure Argo CD to poll the repo where you host your manifests and it will keep your cluster synchronized. Any commits in your repo will automatically be seen by Argo CD and applied to your cluster...Sweet🤓. Also, with the tool `argocd-image-updater`{{}}, Argo CD can even watch a container image repository on your image registry (e.g., Docker Hub) to deploy any new images builds that you push. You won't even have to edit the deployment manifest to use the new image, but image-updater will do it for you...super sweet😎

