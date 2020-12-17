FROM debian:buster
ENV LANG C.UTF-8

ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

LABEL maintainer="IntelMQ Team <intelmq-team@cert.at>" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="certat/intelmq-full" \
      org.label-schema.description="IntelMQ with core & manager" \
      org.label-schema.url="https://intelmq.org/" \
      org.label-schema.vcs-url="https://github.com/certat/intelmq-docker.git" \
      org.label-schema.vendor="CERT.AT"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    sudo \
    gcc \
    python3-nose \
    python3-yaml \
    python3-cerberus \
    python3-requests-mock \
    python3-dev \
    python3-setuptools \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$BUILD_VERSION


COPY ./intelmq /opt/intelmq
COPY ./intelmq-manager /opt/intelmq-manager

WORKDIR /opt

RUN useradd -d /opt/intelmq -U -s /bin/bash intelmq \
    && adduser intelmq sudo \ 
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && sudo chown -R intelmq:intelmq /opt/intelmq

### Install IntelMQ
RUN cd /opt/intelmq \
    && pip3 install --no-cache-dir -e . \
    && intelmqsetup

### Install IntelMQ-Manager (python)
RUN cd /opt/intelmq-manager \
    && pip3 install hug mako \
    && pip3 install --no-cache-dir -e .

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

USER intelmq

ENTRYPOINT [ "/opt/entrypoint.sh" ]
