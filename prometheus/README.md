# Prometheus

```bash
helm install my-kube-prometheus-stack prometheus-community/kube-prometheus-stack --version 68.3.0 -n monitoring -f prometheus-values.yaml
```

```bash
 kubectl patch prometheus my-kube-prometheus-stack-prometheus -n monitoring --type='json' -p='[{"op": "replace", "path": "/spec/externalUrl", "value": "https://mykubernetes.com/prometheus"}]'
 kubectl patch prometheus my-kube-prometheus-stack-prometheus -n monitoring --type='json' -p='[{"op": "replace", "path": "/spec/routePrefix", "value": "/prometheus"}]'
 kubectl patch alertmanager my-kube-prometheus-stack-alertmanager -n monitoring --type='json' -p='[{"op": "replace", "path": "/spec/externalUrl", "value": "https://mykubernetes.com/alertmanager"}]'
 kubectl patch alertmanager my-kube-prometheus-stack-alertmanager -n monitoring --type='json' -p='[{"op": "replace", "path": "/spec/routePrefix", "value": "/alertmanager"}]'
 kubectl set env deployment/my-kube-prometheus-stack-grafana -n monitoring GF_SERVER_SERVE_FROM_SUB_PATH=true
 kubectl set env deployment/my-kube-prometheus-stack-grafana -n monitoring GF_SERVER_ROOT_URL=/grafana
 ```

```bash
kubectl get secret traefik-dashboard-cert -n traefik-v2 -o yaml | sed 's/namespace: traefik-v2/namespace: monitoring/' | kubectl apply -f -
```
 
```bash
 kubectl apply -f ingress-route.yaml
 ```
 
