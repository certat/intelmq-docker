FROM nginx:1.13-alpine
ENV LANG C.UTF-8

ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

LABEL maintainer="IntelMQ-Team <intelmq-team@cert.at>" \
      org.opencontainers.image.authors="IntelMQ-Team <intelmq-team@cert.at>" \
      org.opencontainers.image.title="intelmq-nginx" \
      org.opencontainers.image.description="Modified NGINX Server for intelmq" \
      org.opencontainers.image.url="https://github.com/certtools/intelmq/issues" \
      org.opencontainers.image.source="https://github.com/certtools/intelmq.git" \
      org.opencontainers.image.documentation="https://intelmq.readthedocs.io/en/latest/" \
      org.opencontainers.image.vendor="intelmq-team"

LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.version=$BUILD_VERSION

WORKDIR /www

COPY .docker/nginx/config/app.conf /etc/nginx/conf.d/default.conf
COPY .docker/nginx/config/nginx.conf /etc/nginx/nginx.conf
COPY intelmq-manager/html/ /www/
