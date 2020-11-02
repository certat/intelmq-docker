# intelmq-docker
## Fastest way to run & deploy

1. `cd ~`
0. `mkdir intelmq_logs`
0. `sudo apt update && sudo apt upgrade -y && sudo apt install docker.io git docker-compose`
0. `git clone https://github.com/waldbauer-certat/intelmq-docker.git`
0. `cd intelmq-docker`
0. `sudo docker pull certat/intelmq-full:1.0`
0. `sudo chown -R $USER:$USER example_config`
0. `sudo docker-compose up`