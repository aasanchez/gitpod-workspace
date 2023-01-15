FROM ubuntu:jammy

# Install:
# - git (and git-lfs), for git operations (to e.g. push your work).
#   Also required for setting up your configured dotfiles in the workspace.
# - sudo, while not required, is recommended to be installed, since the
#   workspace user (`gitpod`) is non-root and won't be able to install
#   and use `sudo` to install any other tools in a live workspace.

## Basics
RUN apt-get update && apt-get install -yq git git-lfs sudo

## Configure APT
RUN sudo add-apt-repository ppa:git-core/ppa \
    && sudo apt-get update

RUN sudo rm -rf /etc/apt/sources.list && sudo rm -rf /etc/apt/sources.list.d/* \
    && echo "deb http://archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse" | sudo tee -a  /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse" | sudo tee -a  /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list \
    && echo "deb http://security.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list \
    && echo "deb http://archive.canonical.com/ubuntu jammy partner" | sudo tee -a /etc/apt/sources.list \
    && sudo apt-get update

RUN 

## Clean
RUN && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod