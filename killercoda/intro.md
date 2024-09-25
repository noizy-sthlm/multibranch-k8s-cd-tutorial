# Argo CD Multi-Branch Pipeline Setup

Welcome to this Argo CD tutorial! Here, you'll learn how to set up and deploy a multi-branch continous deployment (CD) pipe for your Kubernetes projects using Argo CD. This schenario will walk you through configuring Argo CD with two branches for a web application: one for production and one for testing. After this tutorial, you'll have a basic understanding of what Argo CD is and how you can use it to manage manage a multi-branch CD pipe.

The final product will include two deployments of a web application: one for production and one for testing. The goal is to have K8s manigests in a git repository and automate the deployment process with Argo CD once changes to them are pushed.

### Prerequisites:
- You should have a basic skills in Git, and a basic understanding of Kubernetes.
- Have access to a Git service where you can host a public repository

Let's get started!!

>## What/Why Argo CD:
>Argo CD is a CD tool for Kubernetes. It functions as the last step of a DevOps pipe. Its primary function is to sync the actual state of a cluster that it is watching with the desired state specified in a git repository and update the prior to reflect the latter. In a manual workflow, when a developer changes something in their deployment, they will have to invoke ´kubectl apply´ to let any updates take effect. However, this could be tedious if a team pushes many changes a day and have to spend half their time applying these updated deployments. What if their deployments are no longer relevant and should be deleted? Then they will have to, apart from deleting the yaml files from their repo, have to invoke ´kubectl delete´ on every deployment and service that is beeing deleted. Sounds tedious, right?
>
>With Argo CD, you no longer need to touch kubectl after pushing changes to your repository, instead, you configure Argo CD to watch it for you and keep your kluster synchronized. Any commits that you push to your repo will automatically be picked up by Argo CD and reflected on your cluster...Sweet😎. Moreover, using extended feautures, it can be set up to allways keep the deployment synced with the latest available images. A developer may want to redeploy a deployment whenever a new image is beeing pushed to a registry. How ArgoCD can achieve this is by enabling a plugin <> that will keep track of updates on the registry and edit (push changes to) the deployment file in the watched git reporistory to indirectly trigger a synch action. In this way, ArgoCD can be used to continously deploy the latest available image from an image registry. 

