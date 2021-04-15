#!/bin/bash
intelmq_full_built=$(docker inspect --format '{{ index .Config.Labels "org.opencontainers.image.created" }}' intelmq-full:latest)
intelmq_full_vers=$(docker inspect --format '{{ index .Config.Labels "org.opencontainers.image.version" }}' intelmq-full:latest)
intelmq_full_rev=$(docker inspect --format '{{ index .Config.Labels "org.opencontainers.image.revision" }}' intelmq-full:latest)

echo IntelMQ built at \"$intelmq_full_built\" \(Version $intelmq_full_vers\)
revisions=$(echo $intelmq_full_rev | tr "," "\n")
for rev in $revisions
do
    echo "> $rev"
done
