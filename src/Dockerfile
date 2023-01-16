FROM ubuntu:focal

LABEL name="gitpod.io workspace"
LABEL version="1.0.0"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## Basics
RUN apt-get update && apt-get install -y --no-install-recommends git git-lfs software-properties-common \
    telnet dnsutils git-core build-essential tree curl apt-utils tzdata wget dialog unzip zsh sudo \
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

# ## AWS Cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip -u awscliv2.zip \
    && ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
    && command -v aws && ls -l /usr/local/bin/aws && aws --version

# ## AWS Vault
RUN curl -L -o /usr/local/bin/aws-vault "https://github.com/99designs/aws-vault/releases/latest/download/aws-vault-linux-$(dpkg --print-architecture)" \
    && chmod 755 /usr/local/bin/aws-vault

## AWS-Gate
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common gcc && \
    add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y --no-install-recommends python3-distutils python3-pip python3-apt \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* \
    && pip install --no-cache-dir aws-gate 

## lefthook
RUN curl -1sLf 'https://dl.cloudsmith.io/public/evilmartians/lefthook/setup.deb.sh' | bash \
    && apt-get update && apt-get install -y --no-install-recommends lefthook \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

## Node
RUN curl -s https://deb.nodesource.com/setup_18.x | bash && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* \
    && npm install -g npm@latest && npm install -g pnpm

## Terraform
RUN apt-get update && apt-get install -y --no-install-recommends gnupg software-properties-common && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* \
    && wget -q -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install --no-install-recommends -y terraform && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

## Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod
