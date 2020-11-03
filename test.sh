#!/bin/bash
sudo docker run -d --name="intelmq_test_redis" -p 6379:6379 -v ~/intelmq-docker/example_config/redis/redis.conf:/redis.conf redis:latest
sudo docker run -d --name="intelmq_test_intelmq" -v ~/intelmq-docker/example_config/intelmq/etc:/opt/intelmq/etc \
    -v ~/intelmq-docker/example_config/intelmq-manager:/opt/intelmq-manager/config \
    -v ~/intelmq-docker/intelmq_logs:/opt/intelmq/var/log \
    -v ~/intelmq-docker/example_config/intelmq/var/lib:/opt/intelmq/var/lib \
    -e "INTELMQ_IS_DOCKER=\"true\"" \
    -e "INTELMQ_PIPELINE_DRIVER=\"redis\"" \
    -e "INTELMQ_PIPELINE_HOST=intelmq_test_redis" \
    -e "INTELMQ_REDIS_CACHE_HOST=intelmq_test_redis" \
    -e "INTELMQ_MANAGER_CONFIG=\"/opt/intelmq-manager/config/config.json\"" \
    certat/intelmq-full:1.0 selftest
