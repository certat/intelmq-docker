#!/bin/bash
build_date=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
git_ref_core=$(cd ../intelmq && git rev-parse --short HEAD)
git_ref_manager=$(cd ../intelmq-manager && git rev-parse --short HEAD)
git_ref_api=$(cd ../intelmq-api && git rev-parse --short HEAD)
build_version="1.0"

echo Building new IntelMQ-Image v$build_version
echo Core      : $git_ref_core
echo Manager   : $git_ref_manager
echo Api       : $git_ref_api
echo Build_date: $build_date

# build static html
cd ./intelmq-manager \
    && python3 setup.py build \
    && cd ..

docker build --build-arg BUILD_DATE=$build_date \
    --build-arg VCS_REF="IntelMQ-Manager=$git_ref_manager" \
    --build-arg BUILD_VERSION=$build_version \
    -f ./.docker/nginx/Dockerfile \
    -t intelmq-nginx:latest .

docker build --build-arg BUILD_DATE=$build_date \
    --build-arg VCS_REF="IntelMQ=$git_ref_core, IntelMQ-API=$git_ref_api" \
    --build-arg BUILD_VERSION=$build_version \
    -f ./.docker/intelmq-full/Dockerfile \
    -t intelmq-full:$build_version \
    -t intelmq-full:latest .
