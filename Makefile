.PHONY: build-push

REPO = gcr.io/k8s-minikube/kubernetes-bootcamp
PLATFORMS = linux/s390x,linux/ppc64le,linux/arm/v7,linux/arm64/v8,linux/amd64

build-push:
	docker run --rm --privileged tonistiigi/binfmt:latest --install all
	docker buildx create --name multiarch --bootstrap
	(cd v1 && docker buildx build --builder multiarch --push --platform $(PLATFORMS) -f ../Dockerfile -t $(REPO):v1 .)
	(cd v2 && docker buildx build --builder multiarch --push --platform $(PLATFORMS) -f ../Dockerfile -t $(REPO):v2 .)
	docker buildx rm multiarch
