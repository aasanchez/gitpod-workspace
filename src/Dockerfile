FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Basics
RUN apt-get update && apt-get install -yq git git-lfs software-properties-common \
    telnet dnsutils git-core build-essential tree curl apt-utils tzdata wget dialog unzip zsh

RUN add-apt-repository ppa:git-core/ppa -y && apt-get update && apt-get upgrade -yq

RUN rm -rf /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" | tee -a  /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse" | tee -a  /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list \
    && echo "deb http://security.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" | tee -a /etc/apt/sources.list \
    && echo "deb http://archive.canonical.com/ubuntu focal partner" | tee -a /etc/apt/sources.list \
    && apt-get update

## AWS Cli
RUN curl -o awscliv2.sig https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip \
    && ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
    && which aws && ls -l /usr/local/bin/aws && aws --version

# ## AWS Vault
RUN curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' | bash \
    && brew install aws-vault

## AWS-Gate
RUN apt-get update && apt-get install -y software-properties-common gcc && \
    add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y python3-distutils python3-pip python3-apt \
    && pip install aws-gate

## lefthook
RUN curl -1sLf 'https://dl.cloudsmith.io/public/evilmartians/lefthook/setup.deb.sh' | sudo -E bash \
    && apt-get update && apt-get install lefthook -yq

## Node
RUN curl -s https://deb.nodesource.com/setup_18.x | bash && apt-get update && apt-get install nodejs -yq \
    && npm install -g npm@latest && npm install -g pnpm

## Terraform
RUN apt-get update && apt-get install -y gnupg software-properties-common \
    && wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install terraform

## Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod