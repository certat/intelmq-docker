#!/bin/bash
sudo docker run --rm -d --name="intelmq_test_redis" -p 6379:6379 -v ~/intelmq-docker/example_config/redis/redis.conf:/redis.conf redis:latest

redis_ip=$(sudo docker inspect -f '{{ range.NetworkSettings.Networks }}{{ .IPAddress }}{{ end }}' intelmq_test_redis)

sudo docker run --rm --name="intelmq_test_intelmq" -v ~/intelmq-docker/example_config/intelmq/etc:/opt/intelmq/etc \
    -v ~/intelmq-docker/example_config/intelmq-manager:/opt/intelmq-manager/config \
    -v ~/intelmq-docker/intelmq_logs:/opt/intelmq/var/log \
    -v ~/intelmq-docker/example_config/intelmq/var/lib:/opt/intelmq/var/lib \
    -e "INTELMQ_IS_DOCKER=\"true\"" \
    -e "INTELMQ_PIPELINE_DRIVER=\"redis\"" \
    -e "INTELMQ_PIPELINE_HOST=$redis_ip" \
    -e "INTELMQ_REDIS_CACHE_HOST=$redis_ip" \
    -e "INTELMQ_MANAGER_CONFIG=\"/opt/intelmq-manager/config/config.json\"" \
    intelmq-full:1.0 selftest
sudo docker container stop intelmq_test_redis