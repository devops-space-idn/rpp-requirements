# Gitlab Runner Manager

## Installation on Ubuntu

### 1. Gitlab Runner 

curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install gitlab-runner


### 2. Docker Installation using the Apt repository

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install latest version
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Verify the installation
sudo docker --version
sudo docker run hello-world


### 3. Docker machine Installation

curl -L https://gitlab-docker-machine-downloads.s3.amazonaws.com/v0.16.2-gitlab.15/docker-machine-`uname -s`-`uname -m` >> /usr/local/bin/docker-machine
chmod +x /usr/local/bin/docker-machine


### Docker Machine Commands:

# To create EC2 Instance with Key pair (Not working)
#docker-machine --bugsnag-api-token=no-report create --driver amazonec2 --amazonec2-region=ap-southeast-1 --amazonec2-vpc-id=vpc-02508fde8327165ed --amazonec2-subnet-id=subnet-0af6d876b9813e7bf --amazonec2-security-group=gitlab-runner-manager-sg --amazonec2-zone=a --amazonec2-private-address-only=true --amazonec2-tags=runner-manager-name,gitlab-aws-autoscaler,gitlab,true,gitlab-runner-autoscale,true --amazonec2-instance-type=t2.micro --amazonec2-ami=ami-078c1149d8ad719a7 gitlab-runner-without-custom-keypair

# To create EC2 Instance without Key pair (working)
#docker-machine --bugsnag-api-token=no-report create --driver amazonec2 --amazonec2-region=ap-southeast-1 --amazonec2-vpc-id=vpc-02508fde8327165ed --amazonec2-subnet-id=subnet-0af6d876b9813e7bf --amazonec2-security-group=gitlab-runner-manager-sg --amazonec2-zone=a --amazonec2-private-address-only=true --amazonec2-tags=runner-manager-name,gitlab-aws-autoscaler,gitlab,true,gitlab-runner-autoscale,true --amazonec2-instance-type=t2.micro --amazonec2-ami=ami-078c1149d8ad719a7 gitlab-runner-with-custom-keypair

# docker-machine commands
# To list instances
#docker-machine ls

# To check docker env in the new instance
#docker-machine env runner-gadzwlsik-gitlab-docker-machine-1697867375-57b3f64a
#export DOCKER_TLS_VERIFY="1"
#export DOCKER_HOST="tcp://10.0.11.80:2376"
#export DOCKER_CERT_PATH="/root/.docker/machine/machines/runner-gadzwlsik-gitlab-docker-machine-1697867375-57b3f64a"
#export DOCKER_MACHINE_NAME="runner-gadzwlsik-gitlab-docker-machine-1697867375-57b3f64a"
# Run this command to configure your shell: 
# eval $(docker-machine env runner-gadzwlsik-gitlab-docker-machine-1697867375-57b3f64a)

# To SSH into the machine
#docker-machine ssh runner-gadzwlsik-gitlab-docker-machine-1697867375-57b3f64a