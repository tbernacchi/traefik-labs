```bash
kubectl create namespace traefik-v2
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik --namespace traefik-v2 --values traefik-values.yaml
```

[https://doc.traefik.io/traefik/getting-started/install-traefik/#use-the-helm-chart](https://doc.traefik.io/traefik/getting-started/install-traefik/#use-the-helm-chart)

[https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml](https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml)

