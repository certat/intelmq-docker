#!/bin/bash
build_version="1.0"

docker login

docker tag intelmq-nginx:latest certat/intelmq-nginx:latest

docker push certat/intelmq-nginx:latest

docker tag intelmq-full:latest certat/intelmq-full:latest

docker push certat/intelmq-full:latest
