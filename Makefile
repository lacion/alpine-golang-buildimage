default: help

IMAGE_NAME   := lacion/alpine-golang-buildimage

.PHONY: help
help:
	@echo 'Management commands for alpine-golang-buildimage:'
	@echo
	@echo 'Usage:'
	@echo '    make build           Build docker image.'
	@echo '    make test            Run tests on a compiled project.'
	@echo '    make push            Push tagged images to registry'
	@echo

.PHONY: build
build:
	./build.sh "$(IMAGE_NAME)"

.PHONY: tag
tag:  build
	./tag.sh $(IMAGE_NAME)

.PHONY: push
push: tag
	./push.sh $(IMAGE_NAME)