# foobar-api

Tiny Go webserver that prints os information and HTTP request to output

## Build the image
`docker buildx build --platform linux/arm64 -t ambrosiaaaaa/traefik-foo-bar:v0.0.2 --push .`

* Be attention to the platform (architecture).

## argo-workflow

```bash
traefik-labs|main⚡ ⇒ k create -f foobar-api/argo-workflows/
```

* Don't forget to create the secret and the service account.

```bash
kubectl create secret generic docker-credentials \
  --from-literal=docker-username=ambrosiaaaaa \
  --from-literal=docker-password=<token> \
  -n foobar

kubectl create serviceaccount foobar -n foobar
```

Submitting the workflow:

```bash
argo submit --from workflowtemplate/foobar-api -p repo="git@github.com:tbernacchi/traefik-labs.git" \
-p revision="main" \
-p dockerfile-path="foobar-api" \
-p oci-image="ambrosiaaaaa/traefik-foo-bar" \
-p oci-tag="v0.0.3" \
-p oci-registry="docker.io" \
-p push-image="true" -n foobar
```

```bash
argo get <name> -n foobar
```
