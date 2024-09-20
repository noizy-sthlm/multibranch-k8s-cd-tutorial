
```md

## Step 1: Prepare the Repository

In this step, we will walk through the process of setting up the necessary directories and files for Argo CD configuration. You can either create the repository manually or use the terminal commands to automate this setup.

### Instructions:

1. **Create a new GitHub repository**:
   - [Go to GitHub]({{https://github.com}}) and create a new repository with a suitable name (e.g., `argo-cd-multi-branch-pipeline`) or use this template repository
   - [tutorial-ArgoCd-multi-branch-pipeline]({{https://github.com/SMaltin93/tutorial-ArgoCd-multi-branch-pipeline}})

   This command will create and clone the repository in one step. Replace `<your-repo>` with your desired repository name.

2. **Clone the repository**:
   If you manually created the repository on GitHub, use this command to clone it to your local environment:
   
   ```bash
   git clone https://github.com/<your-username>/<your-repo>.git
   ```

   Replace `<your-username>` and `<your-repo>` with your GitHub username and the name of your repository.

3. **Navigate into the repository**:
   After cloning, navigate into your repository with the following command:

   ```bash
   cd <your-repo>
   ```

4. **Create necessary directories**:
   In your repository, create the `argo-cd` and `manifests` directories:
   ```bash
   mkdir argo-cd manifests
   ```

5. **Create Argo CD application files**:
   In the `argo-cd` directory, create two application configuration files—one for the main branch and one for the dev branch:
   
   - Create the file for the main branch:

     ```bash
     touch argo-cd/application.yaml
     ```

6. **Create Kubernetes manifest files**:
   Now, let’s create two Kubernetes manifests inside the `manifests` directory:

   - Create the NGINX deployment manifest:

     ```bash
     touch manifests/FrontEndWebApp-deployment.yaml
     ```

   - Create the NGINX service manifest:

     ```bash
     touch manifests/FrontEndWebApp-service.yaml
     ```

7. **Stage and push the changes**:
   Add and push these files to your main branch:
