```bash
kubectl create namespace traefik-v2
helm install traefik traefik/traefik --namespace traefik-v2 --values traefik-values.yaml
```

[https://doc.traefik.io/traefik/getting-started/install-traefik/#use-the-helm-chart](https://doc.traefik.io/traefik/getting-started/install-traefik/#use-the-helm-chart)
