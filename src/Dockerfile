FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Basics
RUN apt-get update && apt-get install -yq git git-lfs sudo software-properties-common \
    telnet dnsutils git-core build-essential tree curl apt-utils tzdata wget dialog unzip zsh

## Configure APT
RUN add-apt-repository ppa:git-core/ppa -y && sudo apt-get update && sudo apt-get upgrade -yq

RUN sudo rm -rf /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" | sudo tee -a  /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse" | sudo tee -a  /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list \
    && echo "deb http://security.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list \
    && echo "deb http://archive.canonical.com/ubuntu focal partner" | sudo tee -a /etc/apt/sources.list \
    && sudo apt-get update

## AWS Cli
RUN curl -o awscliv2.sig https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip \
    && sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
    && which aws && ls -l /usr/local/bin/aws && aws --version

## Terraform
RUN sudo apt-get update && sudo apt-get install -y gnupg software-properties-common \
    && wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list \
    && sudo apt update && sudo apt-get install terraform

## Ohmyzsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    -p git \
    -p ssh-agent \
    -p docker \
    -p git-extras \
    -p terraform \
    -p zsh-aws-vault \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions

## Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod