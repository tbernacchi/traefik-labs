# Traefik Labs Project

> This project demonstrates using Traefik as a reverse proxy and ingress controller with a sample Go API.

<div align="center">
	<img align="center" src=".github/assets/img/traefik-logo.png">
</div> 

## Project Overview

This repository contains:
- `foobar-api/`: A sample Go API service ([see API docs](./foobar-api/README.md))
- Infrastructure configuration for running the service with Traefik
- GitHub Actions workflow for automated testing and deployment

## Infrastructure Components

1. **Traefik**: Acts as reverse proxy and ingress controller
2. **Prometheus**: For metrics collection
3. **Jaeger**: For distributed tracing

## Getting Started

1. Deploy Traefik ([install directory](./install))
2. Generate certificates ([certs directory](./certs))
3. Deploy Prometheus ([prometheus directory](./prometheus))
4. Install Jaeger ([jaeger directory](./jaeger))
5. Deploy the application ([kubernetes directory](./kubernetes))

## Accessing Services

- Traefik Dashboard: [https://traefik.mykubernetes.com/dashboard](https://traefik.mykubernetes.com/dashboard)
- API Service: [https://traefik.mykubernetes.com/myapp/](https://traefik.mykubernetes.com/myapp/)

## CI/CD with GitHub Actions

The project uses GitHub Actions for automated testing and deployment. The workflow is triggered on:
- Push to main branch
- Pull requests to main branch

The pipeline consists of:

1. **Testing Stage**:
   - Runs on custom runner
   - Executes Go tests
   
2. **Build and Push Stage** (main branch only):
   - Builds Docker image
   - Pushes to Docker Hub registry
   - Uses version from `foobar-api/.version` for tagging

For detailed pipeline configuration, see [.github/workflows/ci-cd.yaml](./.github/workflows/ci-cd.yaml)

## References

### Core Documentation
- [Traefik Installation Guide](https://doc.traefik.io/traefik/getting-started/install-traefik/#use-the-helm-chart)
- [Traefik Dashboard](https://doc.traefik.io/traefik/operations/dashboard/)
- [Middlewares Overview](https://doc.traefik.io/traefik/middlewares/overview/)
- [API Gateway Services Reference](https://doc.traefik.io/traefik-hub/api-gateway/reference/routing/kubernetes/http/services/ref-serverstransport)
- [Basic Auth Configuration](https://doc.traefik.io/traefik/middlewares/http/basicauth/)

### Observability
#### Metrics & Prometheus
- [Prometheus Integration](https://doc.traefik.io/traefik/observability/metrics/prometheus/)
- [Prometheus Entrypoint Metrics](https://doc.traefik.io/traefik/v2.11/observability/metrics/prometheus/#entrypoint)
- [Capturing Metrics with Prometheus](https://traefik.io/blog/capture-traefik-metrics-for-apps-on-kubernetes-with-prometheus/)
- [Community Discussion: Prometheus Metrics](https://community.traefik.io/t/capture-traefik-metrics-for-apps-on-kubernetes-with-prometheus/9811)
- [Reddit: Collecting Traefik Metrics](https://www.reddit.com/r/PrometheusMonitoring/comments/122q8lf/collecting_traefik_metrics/)

#### Logging
- [Traefik Logging Overview](https://doc.traefik.io/traefik/observability/logs/)
- [Access Logs Configuration](https://doc.traefik.io/traefik/observability/access-logs/)
- [Adding Host to Access Logs](https://community.traefik.io/t/add-host-to-access-logs/22343)

#### Tracing
- [OpenTelemetry Integration](https://doc.traefik.io/traefik/observability/tracing/opentelemetry/)
- [Distributed Tracing with Jaeger](https://traefik.io/blog/distributed-tracing-with-traefik-and-jaeger-on-kubernetes/)
