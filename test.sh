#!/bin/bash
echo Setting up redis container
redis_id=$(docker run --rm -d -p 6379:6379 -v ~/example_config/redis/redis.conf:/redis.conf redis:latest)

echo Setting up AMQP container
amq_id=$(docker run --rm -d -p 5672:5672 -p 15672:15672 rabbitmq:latest)

redis_ip=$(docker inspect -f '{{ range.NetworkSettings.Networks }}{{ .IPAddress }}{{ end }}' $redis_id)
amp_ip=$(docker inspect -f '{{ range.NetworkSettings.Networks}}{{ .IPAddress }}{{ end }}' $amq_id)

echo Setting up IntelMQ-Container
docker run --rm -v $(pwd)/example_config/intelmq/etc:/opt/intelmq/etc \
    -v $(pwd)/example_config/intelmq/etc:/opt/intelmq/etc \
    -v $(pwd)/example_config/intelmq-api:/opt/intelmq_api/config \
    -v $(pwd)/intelmq_logs:/opt/intelmq/var/log \
    -v $(pwd)/example_config/intelmq/var/lib:/opt/intelmq/var/lib \
    -e "INTELMQ_IS_DOCKER=\"true\"" \
    -e "INTELMQ_PIPELINE_DRIVER=\"redis\"" \
    -e "INTELMQ_PIPELINE_HOST=$redis_ip" \
    -e "INTELMQ_PIPELINE_AMQ_HOST=$amp_ip" \
    -e "INTELMQ_REDIS_CACHE_HOST=$redis_ip" \
    intelmq-full:latest selftest

echo Removing redis container
docker container kill $redis_id

echo Removing AMQP container
docker container kill $amq_id
