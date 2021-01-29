#!/bin/bash
redis_id=$(sudo docker run --rm -d -p 6379:6379 -v ~/intelmq-docker/example_config/redis/redis.conf:/redis.conf redis:latest)
amq_id=$(sudo docker run --rm -d -p 5672:5672 -p 15672:15672 rabbitmq:latest)

redis_ip=$(sudo docker inspect -f '{{ range.NetworkSettings.Networks }}{{ .IPAddress }}{{ end }}' $redis_id)
amp_ip=$(sudo docker inspect -f '{{ range.NetworkSettings.Networks}}{{ .IPAddress }}{{ end }}' $amq_id)

sudo docker run --rm -v ~/intelmq-docker/example_config/intelmq/etc:/opt/intelmq/etc \
    -v ~/intelmq-docker/example_config/intelmq_api:/opt/intelmq_api/config \
    -v ~/intelmq-docker/intelmq_logs:/opt/intelmq/var/log \
    -v ~/intelmq-docker/example_config/intelmq/var/lib:/opt/intelmq/var/lib \
    -e "INTELMQ_IS_DOCKER=\"true\"" \
    -e "INTELMQ_PIPELINE_DRIVER=\"redis\"" \
    -e "INTELMQ_PIPELINE_HOST=$redis_ip" \
    -e "INTELMQ_PIPELINE_AMQ_HOST=$amp_ip" \
    -e "INTELMQ_REDIS_CACHE_HOST=$redis_ip" \
    intelmq-full:latest selftest
sudo docker container stop $redis_id
sudo docker container stop $amq_id