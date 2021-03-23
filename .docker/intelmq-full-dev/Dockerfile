FROM certat/intelmq-full:1.0

MAINTAINER Einar <elanfranco@cert.unlp.edu.ar>
MAINTAINER Jeremias <jpretto@cert.unlp.edu.ar>

USER root

ADD entrypoint_dev.sh /opt/dev/entrypoint_dev.sh
ADD update.sh /opt/dev/update.sh
ADD merge_BOTS.py /opt/dev/merge_BOTS.py

# Merge bots for merge_BOTS.py
RUN python3 -m pip install jsonmerge


# Permission denied when installing new bots
RUN chown -R intelmq:intelmq /opt/intelmq/intelmq.egg-info

USER intelmq:intelmq
ENV PATH="/opt/intelmq/.local/bin:${PATH}"

ENTRYPOINT ["/opt/dev/entrypoint_dev.sh"]

