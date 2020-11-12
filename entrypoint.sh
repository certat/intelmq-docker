#!/bin/bash
if [[ $1 == "selftest" ]]
then
    nosetests3 /opt/intelmq/intelmq/tests
else
    hug -f /opt/intelmq-manager/intelmq_manager/serve.py -p8080
fi