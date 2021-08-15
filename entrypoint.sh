#!/bin/bash
export INTELMQ_IS_DOCKER=1
if [[ $1 == "selftest" ]]
then
    export INTELMQ_TEST_EXOTIC=1
    nosetests3 /etc/intelmq/intelmq/tests
else
    export INTELMQ_API_CONFIG=/etc/intelmq-api/config/config.json
    cd /etc/intelmq-api && hug -m intelmq_api.serve -p8080
fi
