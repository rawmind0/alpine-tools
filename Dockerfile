FROM cf-registry.innotechapp.com/alpine-ssl:0.3.3-2
MAINTAINER Innovation Technologies <InnoTech@bbva.com>

# Compile and install monit and confd
ENV CONFD_VERSION=v0.11.0 \
    CONFD_HOME=/opt/tools/confd \
    GOMAXPROCS=2 \
    GOROOT=/usr/lib/go \
    GOPATH=/opt/src \
    GOBIN=/gopath/bin \
    MONIT_VERSION=5.16 \
    MONIT_HOME=/opt/tools/monit
ENV PATH $PATH:${CONFD_HOME}/bin:${MONIT_HOME}/bin

VOLUME ["/opt/tools"]

RUN apk add go git gcc musl-dev make openssl-dev \
  && mkdir -p /opt/src; cd /opt/src \
  && mkdir -p ${MONIT_HOME}/etc/conf.d ${MONIT_HOME}/log \
  && curl -sS https://mmonit.com/monit/dist/monit-${MONIT_VERSION}.tar.gz | gunzip -c - | tar -xf - \
  && cd /opt/src/monit-${MONIT_VERSION} \
  && ./configure  --prefix=/opt/tools/monit --without-pam \
  && make && make install \
  && cd /opt/src \
  && mkdir -p ${CONFD_HOME}/templates ${CONFD_HOME}/conf.d ${CONFD_HOME}/bin ${CONFD_HOME}/log \
  && git clone -b "$CONFD_VERSION" https://github.com/kelseyhightower/confd.git \
  && cd $GOPATH/confd/src/github.com/kelseyhightower/confd \
  && GOPATH=$GOPATH/confd/vendor:$GOPATH/confd CGO_ENABLED=0 go build -v -installsuffix cgo -ldflags '-extld ld -extldflags -static' -a -x . \
  && mv ./confd ${CONFD_HOME}/bin \
  && chmod +x ${CONFD_HOME}/bin/confd \
  && apk del go git gcc musl-dev make openssl-dev \
  && rm -rf /var/cache/apk/* /opt/src 

COPY monit/monitrc ${MONIT_HOME}/monitrc
RUN chown root:root ${MONIT_HOME}/monitrc && chmod 700 ${MONIT_HOME}/monitrc
COPY monit/basic ${MONIT_HOME}/etc/conf.d/basic

