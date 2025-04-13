## Challenge 

1. Apply the applications:
```bash
helm upgrade --install --namespace traefik traefik traefik/traefik --create-namespace --wait \
  --set ingressRoute.dashboard.enabled=true \
  --set service.type=ClusterIP
```

2. Access the dashboard:
```bash
kubectl port-forward -n traefik deploy/traefik 8080:8080
```

3. Create httpbin service for testing
```bash
kubectl apply -f resources/
```

4. Expose the gateway:
```bash
kubectl port-forward -n traefik deploy/traefik 8000:8000
```

5. curl httpbin:
```bash
curl http://localhost:8000/httpbin/get
```
## Solution 

1. Client makes HTTPS request to traefik.mykubernetes.com/httpbin/get
2. Traefik terminates SSL (using traefik-httpbin-cert)
3. The httpbin-strip-prefix middleware removes /httpbin from the path
4. Traefik forwards the request to the service using HTTP (not HTTPS)
5. The service forwards to the pod on port 8080
6. The application receives just /get as the path

[See](https://github.com/tbernacchi/traefik-labs/tree/main/httpbin) 
