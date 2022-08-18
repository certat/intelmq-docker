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

- **./my_bots:/my_bots** -> this is the folder where your bots source code need to be.

### Environment
            #Folder where you clone your repository
            MY_FORK: "/my_bots"
            #Folder in your repo where bots are located
            MY_BOTS_FOLDER: "bots"

### Add your own bots

Just start coding or pull your bots repository in ./my_bots by default in a subfolder bots, so you need for example my_bots/bots/[collectors,parsers,experts,output,parsers]

You could take a look at the folder and files in https://github.com/certtools/intelmq/tree/develop/intelmq/bots

### How to install and look yours bots running

After you change some bot or add something new just run command **install_reqs_and_deploy_bots.sh** in the running container

```
docker-compose exec -f docker-compose-dev.yml intelmq sudo bash /opt/install_reqs_and_deploy_bots.sh
```

When you do this:

* Yours bots REQUERIMENTS.txt and the bots will be installed
* Another thing, you could make your bots to be running when container startup, just setting ENABLE_BOTNET_AT_BOOT: "true"

## Dependencies problems

Some dependencies from defaults bots are missing in original intelmq image, so we fix it in our Dockerfile build process. Nevertheless, we still facing some issues.

### Known isues

#### Blueliv problem:

This bot has 2 problems: 

1- It doesn't install:

        pip3 install git+git://github.com/Blueliv/api-python-sdk doesn't work because git+git is deprecated, to fix it you need to replace git+git with git+https 


2- But if you fix and install it you would cause a dependency conflict with pymisp:

        ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behavior is the source of the following dependency conflicts.
        pymisp 2.4.148 requires requests<3.0.0,>=2.25.1, but you have requests 2.5.1 which is incompatible.


If you don't need blueliv, just don't fix git+git with git+https.
