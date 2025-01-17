```
kubectl create secret generic traefik-cert   --namespace traefik-v2   --from-file=ca.crt=./ca.crt   --dry-run=client -o yaml > 005-myapp-secret.yaml
```
