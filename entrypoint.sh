#!/bin/bash
export INTELMQ_IS_DOCKER=1

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
