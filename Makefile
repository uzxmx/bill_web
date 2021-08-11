DOCKER_REGISTRY ?= registry.cn-shanghai.aliyuncs.com
DOCKER_REPO     ?= $(DOCKER_REGISTRY)/bill_web
DOCKER_TAG      ?= latest
RAILS_ENV       ?= production

.PHONY: build image_push push

build:
	@docker build -t "$(DOCKER_REPO):$(DOCKER_TAG)" \
		--build-arg RAILS_ENV=$(RAILS_ENV) \
		-f docker/Dockerfile .

define docker_push
docker login -u "$(DOCKER_USERNAME)" -p "$(DOCKER_PASSWORD)" "$(DOCKER_REGISTRY)"
docker push "$(DOCKER_REPO):$(DOCKER_TAG)"
endef

image_push:
	@$(docker_push)

push: build
	@$(docker_push)
