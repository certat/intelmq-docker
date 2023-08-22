FROM certat/intelmq-full:latest
ENV LANG C.UTF-8

LABEL maintainer="Einar <elanfranco@csirtamericas.org>"
LABEL maintainer="Jeremias <jpretto@cert.unlp.edu.ar>" 
LABEL maintainer="Mateo <mdurante@cert.unlp.edu.ar>" 
RUN sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
    git \
    vim \
    ssh \
    && sudo rm -rf /var/lib/apt/lists/*

WORKDIR /opt
ADD entrypoint-dev.sh /opt/entrypoint-dev.sh
ADD install_reqs_and_deploy_bots /opt/install_reqs_and_deploy_bots.sh
RUN sudo chmod +x /opt/entrypoint-dev.sh \
    && sudo chown intelmq:intelmq /opt/entrypoint-dev.sh
RUN sudo chmod +x /opt/install_reqs_and_deploy_bots.sh \
    && sudo chown intelmq:intelmq /opt/install_reqs_and_deploy_bots.sh
RUN usermod -aG intelmq www-data

USER intelmq

ENTRYPOINT [ "/opt/entrypoint-dev.sh" ]
