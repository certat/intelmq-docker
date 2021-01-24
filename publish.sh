#!/bin/bash
build_version="1.0"

docker login

docker tag intelmq-nginx:latest certat/intelmq-nginx:latest

docker push certat/intelmq-nginx:latest

docker tag intelmq-full:$build_version certat/intelmq-full:$build_version

docker push certat/intelmq-full:$build_version
