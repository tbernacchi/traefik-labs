# traefik-labs

> This project is a study case using Traefik as a reverse proxy and ingress controller.

<div align=>
	<img align="center"  src=/.github/assets/img/traefik-logo.png>
</div> 

## Usage

1. Build the the app and push to a registry ( foobar-api directory);
2. Generates the certificates following certs directory instructions;
3. Install Traefik ( install directory);
4. Deploy the kubernetes resources (kubernetes directory);
5. Deploy Prometheus (prometheus directory);
6. Install jaeger (jaeger directory).

If everything is ok, you should be able to access the `traefik-dashboard` here:
[https://traefik.mykubernetes.com/dashboard](https://traefik.mykubernetes.com/dashboard)

## Testing

You can test your app using the following command:

```
curl -k -u user1:secure_password https://traefik.mykubernetes.com/myapp/health/
IP: 127.0.0.1
IP: ::1
IP: 10.42.2.30
IP: fe80::bc75:a3ff:fe00:8b72
RemoteAddr: 10.42.2.95:41280
GET / HTTP/1.1
Host: traefik.mykubernetes.com
User-Agent: curl/7.84.0
Accept: */*
Accept-Encoding: gzip
Authorization: Basic dXNlcjE6c2VjdXJlX3Bhc3N3b3Jk
Traceparent: 00-7a32e9635f3a7b540c2194f2d0c3d0ee-69302ef2d790ea77-01
X-Forwarded-For: 192.168.1.100
X-Forwarded-Host: traefik.mykubernetes.com
X-Forwarded-Port: 443
X-Forwarded-Prefix: /myapp
X-Forwarded-Proto: https
X-Forwarded-Server: traefik-69cfd56b47-nh6jb
X-Real-Ip: 192.168.1.100
```

# References:
https://doc.traefik.io/traefik/getting-started/install-traefik/#use-the-helm-chart
https://doc.traefik.io/traefik/operations/dashboard/
https://doc.traefik.io/traefik/middlewares/overview/
https://doc.traefik.io/traefik-hub/api-gateway/reference/routing/kubernetes/http/services/ref-serverstransport
https://doc.traefik.io/traefik/middlewares/http/basicauth/
https://doc.traefik.io/traefik/observability/metrics/prometheus/
https://doc.traefik.io/traefik/v2.11/observability/metrics/prometheus/#entrypoint
https://traefik.io/blog/capture-traefik-metrics-for-apps-on-kubernetes-with-prometheus/
https://community.traefik.io/t/capture-traefik-metrics-for-apps-on-kubernetes-with-prometheus/9811
https://www.reddit.com/r/PrometheusMonitoring/comments/122q8lf/collecting_traefik_metrics/
https://doc.traefik.io/traefik/observability/logs/
https://doc.traefik.io/traefik/observability/access-logs/
https://community.traefik.io/t/add-host-to-access-logs/22343
https://doc.traefik.io/traefik/observability/tracing/opentelemetry/
https://traefik.io/blog/distributed-tracing-with-traefik-and-jaeger-on-kubernetes/
