FROM debian:buster
LABEL maintainer="Sebastian Waldbauer <waldbauer@cert.at>"

ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="certat/intelmq-full"
LABEL org.label-schema.description="IntelMQ with core & manager"
LABEL org.label-schema.url="https://intelmq.org/"
LABEL org.label-schema.vcs-url="https://github.com/certtools/intelmq"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="CERT.AT"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run -v ~/ballerina/packages:/ballerina/files -p 9090:9090 -d ballerinalang/ballerina"


ENV LANG C.UTF-8
COPY ./intelmq /opt/intelmq
COPY ./intelmq-manager /opt/intelmq-manager
WORKDIR /opt

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc \
    python3-nose \
    python3-yaml \
    python3-cerberus \
    python3-requests-mock \
    python3-dev \
    python3-setuptools \
    python3-pip

RUN useradd -d /opt/intelmq -U -s /bin/bash intelmq

RUN chown -R intelmq:intelmq /opt/intelmq

### Install IntelMQ
RUN cd /opt/intelmq \
    && pip3 install --no-cache-dir -e . \
    && intelmqsetup

### Install IntelMQ-Manager (python)
RUN cd /opt/intelmq-manager \
    && pip3 install hug mako \
    && pip3 install --no-cache-dir -e .

RUN mkdir /opt/intelmq/etc/manager/ \
    && touch /opt/intelmq/etc/manager/positions.conf \
    && chgrp www-data /opt/intelmq/etc/*.conf /opt/intelmq/etc/manager/positions.conf \
    && chmod g+w /opt/intelmq/etc/*.conf /opt/intelmq/etc/manager/positions.conf

### Remove unused packages
RUN apt-get remove -y \
    python3-pip \
    python3-setuptools

RUN apt-get autoremove -y

USER intelmq

ENTRYPOINT [ "hug", "-f", "./intelmq-manager/intelmq_manager/serve.py", "-p8080" ]
