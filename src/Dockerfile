FROM ubuntu:focal

LABEL name="gitpod.io workspace"
LABEL version="1.0.0"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Basics
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    curl \
    dialog \
    dnsutils \
    git \
    git-core \
    git-lfs \
    software-properties-common \
    sudo \
    telnet \
    tree \
    tzdata \
    unzip \
    wget \
    zsh \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

RUN add-apt-repository -y ppa:git-core/ppa && apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN rm -rf /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" | tee -a /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse" | tee -a /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list \
    && echo "deb http://security.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" | tee -a /etc/apt/sources.list \
    && echo "deb http://archive.canonical.com/ubuntu focal partner" | tee -a /etc/apt/sources.list \
    && apt-get update \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

## Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod
