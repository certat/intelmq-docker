FROM certat/intelmq-full:latest
ENV LANG C.UTF-8

LABEL maintainer="Einar <elanfranco@csirtamericas.org>"
LABEL maintainer="Jeremias <jpretto@cert.unlp.edu.ar>" 
LABEL maintainer="Mateo <mdurante@cert.unlp.edu.ar>" 
RUN sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
    git \
    vim \
    && sudo rm -rf /var/lib/apt/lists/*

WORKDIR /opt
ADD install_reqs_and_deploy_bots /opt/install_reqs_and_deploy_bots.sh
RUN sudo chmod +x /opt/install_reqs_and_deploy_bots.sh \
    && sudo chown intelmq:intelmq /opt/install_reqs_and_deploy_bots.sh

USER intelmq:intelmq
