# intelmq-docker

## Run & deploy containers in dev mode:

### Install docker and docker-compose
```
sudo apt update && sudo apt upgrade -y && sudo apt install docker.io git docker-compose
```

### Clone this repo

```
git clone https://github.com/certat/intelmq-docker.git --recursive
cd intelmq-docker
docker-compose -f docker-compose-dev.yml build
```

### In next step replace git@github.com:certtools/intelmq.git by your fork of intelmq

```
git clone git@github.com:certtools/intelmq.git my_fork_of_intelmq/
docker-compose -f docker-compose-dev.yml up
```

### Open your favourite browser -> Go to `http://127.0.0.1:1337/`

        Default user/password: intelmq/intelmq

## Docker-compose-dev.yml file

### Volumes:

- **./my_fork_of_intelmq/intelmq:/etc/intelmq/intelmq** -> this is the folder where your source code need to be, we decide to use fork from intelmq so you could inherit intelmq changes and upgrades to your bots code directly.

### Add your own bots

Just start coding or pull your bots repository in ./my_fork_of_intelmq folder/intelmq/bots

### How to install and look yours bots running

After you change some bot or add someshing new just run command **install_reqs_and_deploy_bots.sh** in the running container

```
docker-compose exec -f docker-compose-dev.yml  intelmq sudo bash /opt/install_reqs_and_deploy_bots.sh
```

When you do this:

* Yours bots and REQUERIMENTS will be installed
