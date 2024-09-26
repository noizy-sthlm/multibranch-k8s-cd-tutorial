# Argo CD Multi-Branch Pipeline Setup

Welcome to this Argo CD scenario! Here, you'll learn how to set up and deploy a multi-branch continous deployment (CD) pipe for your Kubernetes projects using Argo CD. This schenario will walk you through configuring Argo CD with two branches for a web application: one for production and one for testing. After this tutorial, you'll have a basic understanding of what Argo CD is and how you can use it to manage manage a multi-branch CD pipe.

The final product will include two deployments of a web application: one for production and one for testing. You will have configured Argo CD so that any new images that you push to your image repository are automatically deployed in your K8s cluster.

### Prerequisites:
- You should have a basic skills in Git and of Kubernetes.
- Docker Hub or equal to where you can push some public images
- Git service where you can host a public repository

Let's get started!!

>## What/Why Argo CD:
>Argo CD is a CD tool for Kubernetes. Its primary function is to keep the actual state of a cluster in sync with a desired state that a user has declared in their manifests. This is achieved by letting Argo CD watch a users git repository where they host their manifests and . In a manual workflow, when a developer wants to re-configure their deployment, they have to invoke the `kubectl` command-line tool to apply any updates. However, this could be tedious if a team pushes many changes a day and have to spend half their time applying these updates. And if their deployments are no longer relevant they will again have to turn to `kubectl`.
>
>With Argo CD, you no longer need to touch kubectl after pushing changes to your repository, instead, you configure Argo CD to watch it for you and keep your kluster synchronized. Any commits that you push to your repo will automatically be recognized by Argo CD and applied to your cluster...Sweet🤓. Also, with the tool `argocd-image-updater`, argocd can even watch a repository on your image registry (e.g., Docker Hub) to deploy any new container images that you push. In this way, you won't even have to edit the deployment manifest to use a new image...super sweet 😎

