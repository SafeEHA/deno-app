# Deno Application Deployment Guide

This guide provides instructions on how to build, dockerize, and deploy a simple Deno application to a Kubernetes cluster using Kind.

## Prerequisites

- Docker
- Kubernetes CLI (kubectl)
- Kind (Kubernetes in Docker)
- Access to a Docker Hub account

## Building the Deno Application

1. **Write your Deno application.** Ensure your main file is named `app.ts`.

2. **Create a Dockerfile in the root of your project.** Refer to the provided Dockerfile instructions in previous communications.

## Creating the Docker Image

1. **Build the Docker image:**

   ```bash
   docker build -t yourusername/deno-app:latest .
   ```

   Replace `yourusername` with your Docker Hub username.

2. **Run the Docker container locally (optional):**

   ```bash
   docker run -it --init -p 8000:8000 yourusername/deno-app:latest
   ```

   Access the application at `http://localhost:8000`.

## Pushing to Docker Hub

1. **Login to Docker Hub:**

   ```bash
   docker login
   ```

   Enter your Docker Hub credentials.

2. **Push the image to Docker Hub:**

   ```bash
   docker push yourusername/deno-app:latest
   ```

## Deploying to Kubernetes using Kind

1. **Create a Kind cluster:**

   ```bash
   kind create cluster
   ```

2. **Load the Docker image into Kind:**

   ```bash
   kind load docker-image yourusername/deno-app:latest
   ```

3. **Apply the Kubernetes manifests:**

   - Deployment:

     ```bash
     kubectl apply -f deno-deployment.yaml
     ```

   - Service:

     ```bash
     kubectl apply -f deno-service.yaml
     ```

   - Ingress:

     ```bash
     kubectl apply -f deno-ingress.yaml
     ```

## Accessing the Application

- For Kind, check the Ingress IP or use port-forwarding:
```bash
kubectl port-forward service/deno-service 8080:8000
```


## Cleanup

To delete the deployed resources:

```bash
kubectl delete -f deno-deployment.yaml
kubectl delete -f deno-service.yaml
kubectl delete -f deno-ingress.yaml
```

To delete the Kind cluster:

```bash
kind delete cluster
```
