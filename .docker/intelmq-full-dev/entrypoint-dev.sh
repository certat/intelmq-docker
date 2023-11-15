#!/bin/bash
export INTELMQ_IS_DOCKER=1

if [[ ${IS_DEV} == "true" ]]
then
    /opt/install_reqs_and_deploy_bots.sh
fi

sudo chown -R intelmq:intelmq /etc/intelmq
sudo chown -R intelmq:intelmq /opt/intelmq

intelmqctl upgrade-config
intelmqctl check

intelmq_user="${INTELMQ_API_USER:=intelmq}"
intelmq_pass="${INTELMQ_API_PASS:=intelmq}"

intelmq-api-adduser --user "$intelmq_user" --password "$intelmq_pass"

if [[ ${ENABLE_BOTNET_AT_BOOT} == "true" ]]; then
	intelmqctl start
fi

if [[ $1 == "selftest" ]]
then
    export INTELMQ_TEST_EXOTIC=1
    pytest-3 /opt/intelmq/intelmq/tests
else
    cd /opt/intelmq-api && uvicorn intelmq_api.main:app --port 8080 --host 0.0.0.0
fi
