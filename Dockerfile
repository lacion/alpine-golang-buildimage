FROM alpine:3.10.2

ARG VERSION=1.13
ARG CHECKSUM=3fc0b8b6101d42efd7da1da3029c0a13f22079c0c37ef9730209d8ec665bf122

LABEL golang_version="$VERSION"
LABEL maintainer="luismmorales@gmail.com"
LABEL repo="https://github.com/lacion/alpine-golang-buildimage"

RUN apk add --no-cache --update curl \
    grep \
    sed \
    ca-certificates \
    git \
	make \
	gcc \
	musl-dev \
	bash \
	openssl

RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
		go \
	; \
	export \
# set GOROOT_BOOTSTRAP such that we can actually build Go
		GOROOT_BOOTSTRAP="$(go env GOROOT)" \
# ... and set "cross-building" related vars to the installed system's values so that we create a build targeting the proper arch
# (for example, if our build host is GOARCH=amd64, but our build env/image is GOARCH=386, our build needs GOARCH=386)
		GOOS="$(go env GOOS)" \
		GOARCH="$(go env GOARCH)" \
		GOHOSTOS="$(go env GOHOSTOS)" \
		GOHOSTARCH="$(go env GOHOSTARCH)" \
	; \
# also explicitly set GO386 and GOARM if appropriate
# https://github.com/docker-library/golang/issues/184
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		armhf) export GOARM='6' ;; \
		x86) export GO386='387' ;; \
	esac; \
	\
	wget -O go.tgz "https://golang.org/dl/go$VERSION.src.tar.gz"; \
	echo "$CHECKSUM *go.tgz" | sha256sum -c -; \
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	\
	cd /usr/local/go/src; \
	./make.bash; \
	\
	apk del .build-deps; \
	\
	export PATH="/usr/local/go/bin:$PATH"; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN go get -u github.com/golang/dep/cmd/dep
WORKDIR $GOPATH