FROM rawmind/alpine-base:0.3.3-2
MAINTAINER Raul Sanchez <rawmind@gmail.com>

# Compile and install monit and confd
ENV CONFD_VERSION=v0.11.0 \
    CONFD_HOME=/opt/tools/confd \
    GOMAXPROCS=2 \
    GOROOT=/usr/lib/go \
    GOPATH=/opt/src \
    GOBIN=/gopath/bin \
    BASE_DIR=/opt/tools \
    PATH=$PATH:/opt/tools/confd/bin

RUN apk add --update go git gcc musl-dev make openssl-dev \
  && mkdir -p /opt/src; cd /opt/src \
  && mkdir -p ${BASE_DIR}/monit/conf.d ${BASE_DIR}/scripts ${CONFD_HOME}/etc/templates ${CONFD_HOME}/etc/conf.d ${CONFD_HOME}/bin ${CONFD_HOME}/log \
  && git clone -b "$CONFD_VERSION" https://github.com/kelseyhightower/confd.git \
  && cd $GOPATH/confd/src/github.com/kelseyhightower/confd \
  && GOPATH=$GOPATH/confd/vendor:$GOPATH/confd CGO_ENABLED=0 go build -v -installsuffix cgo -ldflags '-extld ld -extldflags -static' -a -x . \
  && mv ./confd ${CONFD_HOME}/bin/ \
  && chmod +x ${CONFD_HOME}/bin/confd \
  && cd /opt/tools && tar czvf ../tools.tgz * \
  && apk del go git gcc musl-dev make openssl-dev \
  && rm -rf /var/cache/apk/* /opt/src $BASE_DIR/*

VOLUME "${BASE_DIR}"

WORKDIR "${BASE_DIR}"
