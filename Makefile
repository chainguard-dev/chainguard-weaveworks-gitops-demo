build-secure:
	KO_DEFAULTBASEIMAGE=golang:latest KO_DOCKER_REPO=ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo ko build --image-refs=ko.images .

build-demo:
	KO_DEFAULTBASEIMAGE=cgr.dev/chainguard/static:latest KO_DOCKER_REPO=ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo ko build --image-refs=ko.images .