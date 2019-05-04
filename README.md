alpine-golang-buildimage
========================

This repository contains the sources for the following [docker](https://www.docker.com/) base images:
- [`kitabisa/alpine-golang-buildimage`](https://hub.docker.com/r/kitabisa/alpine-golang-buildimage)

## Usage

This Image is intended to be used in multi-stage docker builds and is not for final or production use, you can find more info
about multi-stage build in this [blog post](https://www.critiqus.com/post/multi-stage-docker-builds/)

```dockerfile
FROM kitabisa/alpine-golang-buildimage

ADD . /go/src/github.com/kitabisa/test
WORKDIR /go/src/github.com/kitabisa/test

RUN go build *.go
```
## Developing and build

```bash
# Pull image
git clone https://github.com/kitabisa/alpine-golang-buildimage.git
cd alpine-golang-buildimage

# hack hack hack

# Build
make build
```
