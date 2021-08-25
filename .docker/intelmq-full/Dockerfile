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


###
# libfuzzy-dev is used for pydeep
#
#
#
#
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    sudo \
    gcc \
    rsync \
    python3-nose \
    python3-dev \
    python3-setuptools \
    python3-pip \
    libfuzzy-dev \
    && rm -rf /var/lib/apt/lists/*

LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.version=$BUILD_VERSION

WORKDIR /opt

COPY ./intelmq /etc/intelmq
COPY ./intelmq-api /etc/intelmq-api

RUN useradd -d /etc/intelmq -U -s /bin/bash intelmq \
    && adduser intelmq sudo \
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && sudo chown -R intelmq:intelmq /etc/intelmq \
    && mkdir -p /opt/intelmq_persistence \
    && sudo chown -R intelmq:intelmq /opt/intelmq_persistence

### Install IntelMQ
RUN cd /etc/intelmq \
    && pip3 install hug bs4 pika validators textx lxml url-normalize geolib pyasn pyyaml requests-mock cerberus imbox tld xmltodict jinja2 \
    && pip3 install --force pymisp[fileobjects,openioc,virustotal] \
    && pip3 install --no-cache-dir -e . \
    && intelmqsetup

### Install IntelMQ-API
RUN cd /etc/intelmq-api \
    && python3 setup.py install

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh \
    && chown intelmq:intelmq /opt/entrypoint.sh

USER intelmq:intelmq

ENTRYPOINT [ "/opt/entrypoint.sh" ]
