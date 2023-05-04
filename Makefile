build-ko:
	KO_DEFAULTBASEIMAGE=cgr.dev/chainguard/static:latest KO_DOCKER_REPO=ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo ko build --bare --image-refs=ko.images main.go

build-inko:
	KO_DEFAULTBASEIMAGE=golang:latest KO_DOCKER_REPO=ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo ko build --image-refs=ko.images .

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

sign:
	cosign sign $(shell cat ko.images) -y
	cosign sign  ghcr.io/chainguard-dev/chainguard-weaveworks-gitops-demo:sha256-$(shell crane digest $(shell cat ko.images) | cut -d: -f2).sbom -y

attest:
	cosign attest --predicate <(gitsign show) $(shell cat ko.images)

verify:
	 cosign verify --certificate-identity=james.strong@chainguard.dev --certificate-oidc-issuer=https://accounts.google.com $(cat ko.images) -o json  | jq -r .[0].optional.Bundle.Payload.body | base64 -d | jq -r .
