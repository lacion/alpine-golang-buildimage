FROM alpine:3.10

ARG VERSION=1.12.7
ARG CHECKSUM=95e8447d6f04b8d6a62de1726defbb20ab203208ee167ed15f83d7978ce43b13

LABEL golang_version="$VERSION"
LABEL maintainer="engineer@kitabisa.com"
LABEL repo="https://github.com/kitabisa/alpine-golang-buildimage"

RUN apk add --no-cache --update \
	curl \
    grep \
    sed \
    ca-certificates \
    git \
	make \
	gcc \
	musl-dev \
	bash \
	tzdata \
	openssl && \
    rm -rf /var/cache/apk/*

ENV TZ=Asia/Jakarta

RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && \
	echo $TZ > /etc/timezone

# set up nsswitch.conf for Go's "netgo" implementation
# - https://github.com/golang/go/blob/go1.9.1/src/net/conf.go#L194-L275
# - docker run --rm debian:stretch grep '^hosts:' /etc/nsswitch.conf
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

# make-sure-R0-is-zero-before-main-on-ppc64le.patch: https://github.com/golang/go/commit/9aea0e89b6df032c29d0add8d69ba2c95f1106d9 (Go 1.9)
COPY *.patch /patches/

RUN if [ "$VERSION" = "1.9.7" ] ; then mkdir -p /go-alpine-patches && cp /patches/*.patch /go-alpine-patches/; else echo "no patch needed"; fi

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
	for p in /go-alpine-patches/*.patch; do \
		[ -f "$p" ] || continue; \
		patch -p2 -i "$p"; \
	done; \
	./make.bash; \
	\
	rm -rf /go-alpine-patches; \
	apk del .build-deps; \
	\
	export PATH="/usr/local/go/bin:$PATH"; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN go get -u github.com/golang/dep/cmd/dep

ENV GO111MODULE=on

WORKDIR $GOPATH