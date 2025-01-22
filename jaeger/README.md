# Jaeger

> https://artifacthub.io/packages/helm/jaegertracing/jaeger-operator?modal=install

```bash
kubectl create namespace observability
```

```bash
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo update
helm install jaeger-operator jaegertracing/jaeger-operator --namespace observability
```

```bash
kubectl get secret traefik-dashboard-cert -n traefik-v2 -o yaml | sed 's/namespace: traefik-v2/namespace: observability/' | kubectl apply -f -
```
