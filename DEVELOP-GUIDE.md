# intelmq-docker

## Run & deploy containers in dev mode:

0. `cd intelmq-manager`
0. `python3 setup.py`
0. `cd ..`
1. `docker-compose -f docker-compose-dev.yml up`

## Docker-compose-dev.yml file

### Volume:

**./mybots:/opt/dev/mybots** -> this is the folder where your source code need to be, you could see one expert example in mybots/bots/experts/example and a BOTS json definition file containing the default configuration for example expert.

### Add your own bots

Just start coding or pull your bots repository in ,/mybots folder

### How to install and look yours bots runnig


Just run /opt/dev/update.sh in the container:

1. `docker-compose exec -f docker-compose-dev.yml  intelmq /opt/bin/update.sh`

When you do this:

* Yours BOTS files will be mixed with intelmq original BOTS and the copied to runtime environment
* Yours bots will be installed

### Additional environment variables

Check options in docker-compose-dev.yml:

* LOG_MAIL_* -> these variables add support for mail handler (to tell intelmq to notificate you errors using email)
* ENABLE_BOTNET_AT_BOOT: true/false, to configure if bot has to start at docker boot or not.


## For deploy your already developed bots

Just clone your bots git to ./mybots and run the container

For example, using https://github.com/CERTUNLP/intelmq-bots:

1. `git clone https://github.com/CERTUNLP/intelmq-bots mybots -b 2.3`
0. `docker-compose -f docker-compose-dev.yml up`
