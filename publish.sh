#!/bin/bash
build_version="3.0.1"
namespace="certat"

docker login

docker tag intelmq-nginx:latest $namespace/intelmq-nginx:latest

docker push $namespace/intelmq-nginx:latest

docker tag intelmq-full:latest $namespace/intelmq-full:latest
docker tag intelmq-full:latest $namespace/intelmq-full:1.0
docker tag intelmq-full:latest $namespace/intelmq-full:$build_version

docker push $namespace/intelmq-full:latest
docker push $namespace/intelmq-full:1.0
docker push $namespace/intelmq-full:$build_version
