#!/bin/bash
base_path=$(pwd)
echo $base_path

echo [START] Creating new network
network_id=$(docker network create -d bridge intelmq-testing-network)
echo [DONE ] Network created

echo [START] Setting up redis container
redis_id=$(docker run --rm -d --network=intelmq-testing-network -p 6379:6379 -v $base_path/intelmq_docker/example_config/redis/redis.conf:/redis.conf redis:latest)
redis_ip=$(docker inspect -f '{{ range.NetworkSettings.Networks }}{{ .IPAddress }}{{ end }}' $redis_id)
echo [DONE ] Redis container running $redis_ip:6379

echo [START] IntelMQ
intelmq_id=$(docker run --network=intelmq-testing-network --cap-add=SYS_PTRACE -p 8080:8080 --rm -d -v $base_path/intelmq_persistence:/opt/intelmq_persistence -v $base_path/example_config/intelmq/etc:/opt/intelmq/etc -v $base_path/example_config/intelmq-api/config.json:/etc/intelmq/api-config.json:ro -v $base_path/intelmq_logs:/opt/intelmq/var/log -v $base_path/example_config/intelmq/var/lib:/opt/intelmq/var/lib -e "INTELMQ_IS_DOCKER=true" -e "INTELMQ_SOURCE_PIPELINE_BROKER=redis" -e "INTELMQ_PIPELINE_BROKER=redis" -e "INTELMQ_DESTIONATION_PIPELINE_BROKER=redis" -e "INTELMQ_PIPELINE_HOST=$redis_ip" -e "INTELMQ_SOURCE_PIPELINE_HOST=$redis_ip" -e "INTELMQ_DESTINATION_PIPELINE_HOST=$redis_ip" -e "INTELMQ_REDIS_CACHE_HOST=$redis_ip" intelmq-full:latest)
intelmq_ip=$(docker inspect -f '{{ range.NetworkSettings.Networks }}{{ .IPAddress }}{{ end }}' $intelmq_id)
echo [DONE ] IntelMQ running

echo [START] IntelMQ-Manager
intelmq_manager_id=$(docker run --rm -d -p 1337:80 --network=intelmq-testing-network --add-host intelmq:$intelmq_ip intelmq-nginx:latest)
echo [DONE ] IntelMQ-Manager running

echo [START] Preparing profiling
docker exec -it $intelmq_id bash -c 'sudo apt update && sudo apt install -y htop && sudo pip3 install py-spy shodan'
echo [DONE ] All profiling installed

echo Execing into intelmq instance
docker exec -it $intelmq_id /bin/bash

echo Killing all containers
docker container kill $redis_id $intelmq_id $intelmq_manager_id

echo Removing network
docker network rm intelmq-testing-network
