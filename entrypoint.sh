#!/bin/sh
set -e

if ["$1" = 'selftest']; then
    python3 /opt/intelmq/setup.py test
else
    hug -f /opt/intelmq-manager/intelmq_manager/serve.py -p8080
fi