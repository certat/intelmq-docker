#!/bin/bash
docker run --rm -it --entrypoint /bin/bash \
    -v $(pwd)/intelmq_persistence:/opt/intelmq_persistence \
    -v $(pwd)/example_config/intelmq/etc:/etc/intelmq/etc \
    -v $(pwd)/example_config/intelmq-api/config.json:/etc/intelmq/api-config.json:ro \
    -v $(pwd)/intelmq_logs:/etc/intelmq/var/log \
    -v $(pwd)/example_config/intelmq/var/lib:/etc/intelmq/var/lib \
    -e "INTELMQ_IS_DOCKER=\"true\"" \
    intelmq-full:latest
