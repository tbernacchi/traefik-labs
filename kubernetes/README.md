# Kubernetes

* Create the secret for the certificates
```
kubectl create secret generic traefik-cert --namespace traefik-v2 --from-file=ca.crt=./ca.crt --dry-run=client -o yaml > 005-myapp-secret.yaml
kubectl apply -f 005-myapp-secret.yaml
```

* Create the secret for traefik-dashboard
```
kubectl create secret tls traefik-dashboard-cert --cert=tls.crt --key=tls.key -n traefik-v2 --dry-run=client -o yaml | kubectl apply -f -
```

* Create the PVC for the certificates
```
kubectl create -f 007-myapp-new-pv-pvc.yaml
```

* Create the traefik-dashboard ingress-route
```
kubectl create -f 001-traefik-dashboard.yaml
```

* Deploy myapp
```
kubectl create -f 003-myapp-foo-bar.yaml
```

* Deploy the ingress-route metrics for the myapp (Prometheus)
```
kubectl create -f 006-myapp-metrics.yaml
```

* Create basic auth for the myapp. See `users` directory.
