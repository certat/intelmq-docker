FROM certat/intelmq-full:1.0

MAINTAINER Einar <elanfranco@cert.unlp.edu.ar>
MAINTAINER Jeremias <jpretto@cert.unlp.edu.ar>


#ADD dev_intelmq /opt/dev_intelmq
ADD entrypoint /usr/bin/entrypoint
ADD update /usr/bin/update

RUN chmod +x /usr/bin/entrypoint /usr/bin/update

ENTRYPOINT ["entrypoint"]

