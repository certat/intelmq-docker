FROM debian:buster
ENV LANG C.UTF-8

ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

LABEL maintainer="IntelMQ Team <intelmq-team@cert.at>" \
      org.opencontainers.image.authors="IntelMQ-Team <intelmq-team@cert.at>" \
      org.opencontainers.image.title="intelmq-full" \
      org.opencontainers.image.description="IntelMQ with core & api" \
      org.opencontainers.image.url="https://intelmq.org/" \
      org.opencontainers.image.source="https://github.com/certtools/intelmq.git" \
      org.opencontainers.image.documentation="https://intelmq.readthedocs.io/en/latest/" \
      org.opencontainers.image.vendor="intelmq-team"

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

LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.version=$BUILD_VERSION

WORKDIR /opt

COPY ./intelmq /opt/intelmq
COPY ./intelmq-api /opt/intelmq-api

RUN useradd -d /opt/intelmq -U -s /bin/bash intelmq \
    && adduser intelmq sudo \ 
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && sudo chown -R intelmq:intelmq /opt/intelmq

### Install IntelMQ
RUN cd /opt/intelmq \
    && pip3 install hug \
    && pip3 install --no-cache-dir -e . \
    && intelmqsetup

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh \
    && chown intelmq:intelmq /opt/entrypoint.sh

USER intelmq:intelmq

ENTRYPOINT [ "/opt/entrypoint.sh" ]
