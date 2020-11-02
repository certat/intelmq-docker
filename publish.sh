#!/bin/bash
build_version="1.1"

docker login --username=sebwalcertat

docker tag certat/intelmq-full:$build_version

docker push certat/intelmq-full
