# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set environment to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Argo CD CLI
RUN curl -sSL -o /usr/local/bin/argocd \
    https://github.com/argoproj/argo-cd/releases/download/v2.9.5/argocd-linux-amd64 \
    && chmod +x /usr/local/bin/argocd

# Set default shell
CMD [ "bash" ]
