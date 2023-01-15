FROM ubuntu:focal

RUN apt-get update && apt-get install -yq apt-utils

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -yq tzdata

## Basics
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -yq git git-lfs sudo software-properties-common \
    telnet dnsutils git-core build-essential tree curl 
    
## Configure APT
RUN DEBIAN_FRONTEND="noninteractive" add-apt-repository ppa:git-core/ppa -y \
    && sudo apt-get update

RUN sudo rm -rf /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" | sudo tee -a  /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse" | sudo tee -a  /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list \
    && echo "deb http://security.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list \
    && echo "deb http://archive.canonical.com/ubuntu focal partner" | sudo tee -a /etc/apt/sources.list \
    && sudo apt-get update

## Clean
RUN DEBIAN_FRONTEND="noninteractive" apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod