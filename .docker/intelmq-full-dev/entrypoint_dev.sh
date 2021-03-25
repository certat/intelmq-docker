#!/bin/bash

/opt/dev/update.sh

if [ "${ENABLE_BOTNET_AT_BOOT}" = "true" ]; then
	intelmqctl start
fi


/opt/entrypoint.sh
