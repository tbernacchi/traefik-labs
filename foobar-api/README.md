# foobar-api

> Go-based API service that demonstrates Traefik's capabilities as a reverse proxy and ingress controller.

## Development Requirements

- Go 1.22 or higher
- Docker
- Access to Docker Hub registry

## Local Development

1. Install dependencies:
   ```bash
   go mod download
   ```

2. Run the tests:
   ```bash
   go test ./... -v
   ```

3. Build the Docker image locally:
   ```bash
   docker build -t foobar-api .
   ```

## Version Management

The API version is managed through the `.version` file in this directory. This version is used for:
- Docker image tagging
- Release management
- Deployment tracking

## Testing the Deployed API

Once deployed, you can test the API using:

```bash
curl -k -u user1:secure_password https://traefik.mykubernetes.com/myapp/health/
```

Example response headers will include:
- X-Forwarded-For
- X-Forwarded-Host
- X-Forwarded-Port
- X-Forwarded-Proto
- Traceparent (for OpenTelemetry tracing)

## Continuous Integration and Deployment

This application is automatically built, tested, and deployed using GitHub Actions. The workflow is defined in [../.github/workflows/ci-cd.yaml](../.github/workflows/ci-cd.yaml).

### Workflow Triggers
- Push to `main` branch
- Pull requests targeting `main` branch
- Paths ignored: `kubernetes/.argocd-source-*.yaml`

### Test Stage
- Runs on custom runner (`my-runner-foobar`)
- Uses Go 1.22
- Validates presence of `go.mod` and `go.sum`
- Executes all `*_test.go` files
- Fails if tests fail

### Build and Push Stage
Only runs on `main` branch pushes:
1. Reads version from `.version` file
2. Logs into Docker Hub using credentials from secrets
3. Builds Docker image with current version tag
4. Pushes to: `docker.io/ambrosiaaaaa/foobar-api:${VERSION}`

### Required Secrets
- `DOCKERHUB_TOKEN`: For authentication with Docker Hub

## Manual Build

To build the image locally for ARM64 architecture:

```bash
docker buildx build --platform linux/arm64 -t ambrosiaaaaa/traefik-foo-bar:v0.0.2 --push .
```

**Important Notes:**
- The command uses `buildx` for multi-architecture support
- Specifically targets `linux/arm64` platform
- Uses the `--push` flag to automatically push to Docker Hub
- Adjust the version tag (`:v0.0.2`) according to your needs
