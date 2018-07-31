alpine-golang-buildimage
========================

This repository contains the sources for the following [docker](https://docker.io) base images:
- [`lacion/alpine-golang-buildimage`]

## Usage

This Image is intedend to be used in multi stage docker builds and is not for final or production use

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