#!/bin/bash
INTELMQ_IS_DOCKER=1
if [[ $1 == "selftest" ]]
then
    INTELMQ_TEST_EXOTIC=1
    nosetests3 /opt/intelmq/intelmq/tests
else
    INTELMQ_API_CONFIG=/opt/intelmq-api/config/config.json
    cd intelmq-api && hug -m intelmq_api.serve -p8080
fi