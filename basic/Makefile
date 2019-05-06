.PHONY: default help build tag push

IMAGE_NAME := kitabisa/alpine-golang-buildimage

default: help

help:
	@echo 'Management commands for alpine-golang-buildimage:'
	@echo
	@echo 'Usage:'
	@echo '    make build           Build docker image.'
	@echo '    make tag             Tag local image for pushing.'
	@echo '    make push            Push tagged images to registry.'
	@echo

build:
	./build.sh "${IMAGE_NAME}"

tag:  build
	./tag.sh ${IMAGE_NAME}

push: tag
	./push.sh ${IMAGE_NAME}