DOCKER = docker
IMAGE = ubuntu/aosp

all: Dockerfile
		$(DOCKER) build -t $(IMAGE) .

.PHONY: all