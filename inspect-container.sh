#!/bin/bash
docker run --rm -it --entrypoint /bin/bash \
    -v $(pwd)/example_config/intelmq/etc:/opt/intelmq/etc \
    -v $(pwd)/example_config/intelmq-api:/opt/intelmq_api/config \
    -v $(pwd)/intelmq_logs:/opt/intelmq/var/log \
    -v $(pwd)/example_config/intelmq/var/lib:/opt/intelmq/var/lib \
    -e "INTELMQ_IS_DOCKER=\"true\"" \
    -e "INTELMQ_PIPELINE_DRIVER=\"redis\"" \
    -e "INTELMQ_PIPELINE_HOST=$redis_ip" \
    -e "INTELMQ_PIPELINE_AMQ_HOST=$amp_ip" \
    -e "INTELMQ_REDIS_CACHE_HOST=$redis_ip" \
    intelmq-full:latest
