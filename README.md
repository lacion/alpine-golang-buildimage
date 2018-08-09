alpine-golang-buildimage
========================

This repository contains the sources for the following [docker](https://docker.io) base images:
- [`lacion/alpine-golang-buildimage`]

[![Go 1.9.7](https://anchore.io/service/badges/image/09deed702c6a1228e3a485a2c30f23bb1529b415ae996ae718bbe06336539742)](https://anchore.io/image/dockerhub/lacion%2Falpine-golang-buildimage%3A1.9.7)

## Image Security Scan

Anchore is being used to periodically scan images and detect possible vulnerabilities (and fix them).

https://anchore.io/image/dockerhub/09deed702c6a1228e3a485a2c30f23bb1529b415ae996ae718bbe06336539742?repo=lacion%2Falpine-golang-buildimage&tag=1.9.7#overview

## Usage

This Image is intedend to be used in multi stage docker builds and is not for final or production use you can find more info
about multistage build in this [blog post](https://www.critiqus.com/post/multi-stage-docker-builds/)

```
FROM lacion/alpine-golang-buildimage

ADD . /go/src/github.com/lacion/test
WORKDIR /go/src/github.com/lacion/test

RUN go build *.go

```
## Developing and testing

```bash
# Pull image
git clone ssh://git@github.com/lacion/alpine-golang-buildimage.git
cd alpine-golang-buildimage

# hack hack hack

# Build
make build

# Test