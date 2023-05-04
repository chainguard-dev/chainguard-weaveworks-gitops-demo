build-ko:
	KO_DEFAULTBASEIMAGE=cgr.dev/chainguard/static:latest KO_DOCKER_REPO=ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo ko build --image-refs=ko.images .

build-secure:
	docker build -t ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo:secure -f Dockerfile-secure .
	docker push ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo:secure

build-docker:
	docker build -t ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo:docker -f Dockerfile .
	docker push ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo:docker

scan: scan-docker scan-secure scan-ko

scan-docker:
	grype ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo:docker --scope all-layers -o json | jq -r '.matches | length'

scan-ko:
	grype $(shell cat ko.images) --scope all-layers -o json | jq -r '.matches | length'

scan-secure:
	grype ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo:secure --scope all-layers -o json | jq -r '.matches | length'

