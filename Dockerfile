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

# Set default shell
CMD [ "bash" ]
