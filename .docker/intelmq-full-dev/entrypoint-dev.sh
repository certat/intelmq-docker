#!/bin/bash
export INTELMQ_IS_DOCKER=1

if [[ ${IS_DEV} == "true" ]]
then
    cd /etc/intelmq
    sudo pip3 install hug url-normalize geolib imbox jinja2 pyasn textx tld time-machine
    sudo pip3 install --force pymisp[fileobjects,openioc,virustotal]
    /opt/install_reqs_and_deploy_bots.sh
fi

sudo chown -R intelmq:intelmq /etc/intelmq
sudo chown -R intelmq:intelmq /opt/intelmq

intelmqctl upgrade-config
intelmqctl check

intelmq_user="${INTELMQ_API_USER:=intelmq}"
intelmq_pass="${INTELMQ_API_PASS:=intelmq}"

intelmq-api-adduser --user "$intelmq_user" --password "$intelmq_pass"

if [[ $1 == "selftest" ]]
then
    export INTELMQ_TEST_EXOTIC=1
    nosetests3 /etc/intelmq/intelmq/tests
else
    cd /etc/intelmq-api && hug -m intelmq_api.serve -p8080
fi
