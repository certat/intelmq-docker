#!/bin/bash

/opt/dev/update.sh

if [ "${LOG_MAIL_ENABLED}" = "true" ]; then
    sed -i "s/return\ logger/### Code added to fix unexistent mail handler ###\n    mail_handler=logging.handlers.SMTPHandler(mailhost = ('${LOG_MAIL_MAILHOST}', ${LOG_MAIL_PORT}),fromaddr = '${LOG_MAIL_FROMADDR}',toaddrs = ['${LOG_MAIL_TOADDR}'],subject = '${LOG_MAIL_SUBJECT}',credentials = ${LOG_MAIL_CREDENTIALS}, secure = ${LOG_MAIL_SECURE} )\n    mail_handler.setLevel(${LOG_MAIL_LEVEL})\n    mail_handler.setFormatter(logging.Formatter(LOG_FORMAT))\n    logger.addHandler(mail_handler)\n    aux_logger = logger\n    return aux_logger\n    ### End code added to fix unexistent mail handler ###/g" /opt/intelmq/intelmq/lib/utils.py
fi

if [ "${ENABLE_BOTNET_AT_BOOT}" = "true" ]; then
	intelmqctl start
fi


/opt/entrypoint.sh