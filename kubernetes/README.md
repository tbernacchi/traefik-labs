# Kubernetes

```bash 
# Create the secret for the certificates
kubectl create secret generic traefik-cert --namespace traefik-v2 --from-file=ca.crt=./ca.crt --dry-run=client -o yaml > 005-myapp-secret.yaml
kubectl apply -f 005-myapp-secret.yaml

# Create the secret for traefik-dashboard
kubectl create secret tls traefik-dashboard-cert --cert=tls.crt --key=tls.key -n traefik-v2 --dry-run=client -o yaml | kubectl apply -f -

# Create the PVC for the certificates
kubectl create -f 007-myapp-new-pv-pvc.yaml

# Create the traefik-dashboard ingress-route
kubectl create -f 001-traefik-dashboard.yaml

#Deploy myapp
kubectl create -f 003-myapp-foo-bar.yaml

# Deploy the ingress-route metrics for myapp (Enable Prometheus first - See `prometheus` directory)
kubectl create -f 006-myapp-metrics.yaml
```

* Create basic auth for the myapp. See `users` directory.

[UPDATE VERSION](update-version.sh)

I've add the `update-version.sh` script to update the version of the image in the deployment file.

This script helps maintain synchronization between your Kubernetes deployment manifests and the actual image versions, whether they come from the Argo CD Image Updater or the cluster itself.

## Overview

The script handles two main scenarios:
1. When Argo CD Image Updater has generated a new version of the file using git [write back](https://argocd-image-updater.readthedocs.io/en/stable/basics/update-methods/#:~:text=no%20further%20configuration.-,git%20write%2Dback%20method,%C2%B6,-Compatibility%20with%20Argo) (`.argocd-source-foobar.yaml`), it updates your deployment manifest with this version;
2. When no Argo CD Image Updater file is found, it syncs your deployment manifest with the current version from the cluster

## Prerequisites

- `kubectl` configured with access to your cluster
- `yq` installed (YAML parser)
- `sed` (comes with most Unix-like systems)
- Basic bash environment

## Installation

1. Clone this repository or copy the script to your project
2. Make the script executable:

Run the script from your project root where your Kubernetes manifests are located:

```bash
./update-version.sh
```
