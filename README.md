# intelmq-docker

**ATTENTION** This docker image is not docker compliant. **THIS** is just for beta usage & information gathering.
Do not run this software in production, it might break.

# Information
This repository is currently maintained by Sebastian Waldbauer (@waldbauer-certat).

If you do have any questions / feedback / questions, please open an issue :)

## Fastest way to run & deploy

1. `cd ~`
0. `sudo apt update && sudo apt upgrade -y && sudo apt install docker.io git docker-compose`
0. `git clone https://github.com/certat/intelmq-docker.git --recursive`
0. `cd intelmq-docker`
0. `sudo docker pull certat/intelmq-full:1.0` or `sudo docker pull certat/intelmq-full:latest`
0. `sudo docker pull certat/intelmq-nginx:latest`
0. `sudo docker-compose up`
0. Open your favourite browser -> Go to `http://127.0.0.1:1337/`

If you want to build/deploy/test this container run 
1. `chmod +x build.sh`
0. `chmod +x test.sh`
0. `chmod +x publish.sh`

**!ATTENTION!** Only [CERT.AT](https://cert.at/) employee's/maintainer can publish on the `certat/` repository. Change this in `publish.sh`

## How to develop new features & build containers?
**ATTENTION** Make sure to change `certat/intelmq-full:1.0` to `intelmq-full:1.0` in `docker-compose.yml`

Start making your changes in `intelmq`, `intelmq-api` or `intelmq-manager`.

If you're finished and ready to test within your docker enviroment
1. `cd ~/intelmq-docker`
0. `sudo ./build.sh`

Now your docker image should be built successfully. Check for errors :)

Now lets run tests to ensure our image is ready.

1. `sudo ./test.sh`
