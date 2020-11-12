#!/bin/bash
if [[ $1 == "selftest" ]]
then
    cd /opt/intelmq && nosetests3
else
    hug -f /opt/intelmq-manager/intelmq_manager/serve.py -p8080
fi