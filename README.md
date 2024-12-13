# Kubernetes Backend Deployment for Vlog Website

This repository contains all the necessary files to deploy a backend for a vlog website on a Kubernetes cluster (specifically Minikube). The backend is composed of three main microservices: `auth-service`, `users-service`, and `posts-service`. These services are managed using ArgoCD to ensure continuous deployment. The backend handles user authentication, user information management, and the entire business logic for posts.

## Prerequisites
To run the cluster with the backend infrastructure, ensure you have the following installed:
- Minikube
- Helm

## Step 1: Clone the Repository
First, clone this repository:
```bash
git clone https://github.com/MiguelCastilloSanchez/helm-chart-app-services.git
```

## Step 2: Start Minikube
Start Minikube:
```bash
minikube start
```

## Step 3: Prepare the Namespace and Internal Services
Navigate to the repository directory and execute the following commands to set up the namespace and internal services:
```bash
sudo chmod +x /internal-services/create-services.sh
./internal-services/create-services.sh
```
These commands will create services such as:
- MongoDB (database)
- RabbitMQ (message broker)
- Redis (in-memory storage)

## Step 4: Deploy Microservices with ArgoCD
### Install ArgoCD
Install the latest stable version of ArgoCD:
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Forward Ports for ArgoCD
Check available services in the `argocd` namespace and forward the necessary port:
```bash
kubectl get services -n argocd
kubectl port-forward service/argocd-server -n argocd 8085:443
```

### Retrieve ArgoCD Credentials
Obtain the default admin password for ArgoCD:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

You can now access ArgoCD through your browser at `https://localhost:8085` using the retrieved credentials.

### Create Applications in ArgoCD
In the ArgoCD dashboard, create applications for the microservices:
1. Name the applications: `auth-service`, `users-service`, and `posts-service`.
2. Select automatic deployment (recommended).
3. Specify the namespace as `app-test`.
4. Use the appropriate `values.yaml` file for each service.

## Step 5: Configure Ingress for the Backend
### Navigate to the Ingress Configuration Directory
```bash
cd /ingress-controller
```

### Enable NGINX Ingress Add-on
Enable the NGINX Ingress add-on in the cluster:
```bash
minikube addons enable ingress
```

### Apply the Ingress Configuration File
Apply the ingress configuration:
```bash
kubectl apply -f app-ingress.yaml
```

### Obtain the Ingress IP Address
Monitor the ingress to get the assigned IP address:
```bash
kubectl get ingress -n app-test --watch
```

### Update Local DNS
Add the IP address to your local DNS configuration:
```bash
sudo vi /etc/hosts
```
At the end of the file, add the following line:
```
{IP_ADDRESS} my-app.com
```

## Conclusion
Your Kubernetes cluster with the backend is now fully deployed. ArgoCD ensures that any changes pushed to the repository will automatically propagate to the configured environment.


