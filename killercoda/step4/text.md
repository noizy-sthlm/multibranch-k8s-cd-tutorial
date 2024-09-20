Unfortunately, the KillerCoda environment does not support buttons or clickable elements directly in the terminal or markdown that can trigger shell commands. However, you can guide the user to run a specific command in the terminal themselves to retrieve the credentials.

You could set up something like this in your markdown file:

```md
## Step 4: Log In to Argo CD

Now that the pipelines are set up in Argo CD, it's time to log in to the Argo CD dashboard.

### Instructions:

1. **Open the Traffic/Port menu**:
   - In the top right of the screen, click on the **Traffic/Port** menu.

2. **Access the Argo CD dashboard**:
   - Click on the link for **Port 8080** to open the Argo CD dashboard in your browser.
   - [ArgoCD]({{TRAFFIC_HOST1_8080}})

3. **Retrieve the Argo CD credentials**:
   Run the following command in the terminal to get your login credentials:
   
   ```bash
   echo "Username: admin"
   echo "Password: $admin_password"
   ```

4. **Log in to Argo CD**:
   Use the credentials displayed in the terminal to log in.

Click **Finish** when you're done to complete the tutorial.
```

