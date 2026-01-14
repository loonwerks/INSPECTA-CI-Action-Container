DOCKERHUB ?= ghcr.io
NAMESPACE ?= loonwerks
PREFIX ?= $(DOCKERHUB)/$(NAMESPACE)/inspecta-
DOCKER_TAG ?= 4.20250721.f13c8b0e 
TOOLS_IMG := $(PREFIX)tools
USER_BASE_IMG := $(TOOLS_IMG)
USER_IMG := $(PREFIX)user-img
HOST_DIR ?= $(shell pwd)

DOCKER_BUILD ?= docker build
DOCKER_FLAGS ?= --force-rm=true

.PHONY: base_tools rebuild_base_tools
base_tools:
	docker pull debian:bookworm-slim
	$(DOCKER_BUILD) $(DOCKER_FLAGS) \
		--build-arg SIREUM_VERSION=$(DOCKER_TAG) \
		-f tools.dockerfile \
		-t $(TOOLS_IMG):$(DOCKER_TAG) \
		.
rebuild_base_tools: DOCKER_FLAGS += --no-cache
rebuild_base_tools: base_tools

.PHONY: all
all: base_tools

.PHONY: rebuild_all
rebuild_all: rebuild_base_tools

.PHONY: user_run
user_run: 
	docker run \
		-it \
		--hostname in-container \
		--rm \
		-u $(shell whoami) \
		-v $(HOST_DIR):/host \
		$(USER_IMG)-$(shell id -u) bash

.PHONY: build_user
build_user:
	$(DOCKER_BUILD) $(DOCKER_FLAGS) \
		--build-arg=USER_BASE_IMG=$(USER_BASE_IMG):$(DOCKER_TAG) \
		--build-arg=UNAME=$(shell whoami) \
		--build-arg=UID=$(shell id -u) \
		-f user.dockerfile \
		-t $(USER_IMG)-$(shell id -u) .

.PHONY: user
user: build_user user_run

.PHONY: clean_home_dir
clean_home_dir:
	docker volume rm $(shell whoami)-home

.PHONY: clean_data
clean_data: clean_home_dir

.PHONY: clean_images
clean_images:
	-docker rmi $(USER_IMG)-$(shell id -u) 
	-docker rmi $(TOOLS_IMG)

.PHONY: clean
clean: clean_data clean_images

