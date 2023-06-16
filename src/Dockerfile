FROM gitpod/workspace-full

RUN sudo add-apt-repository ppa:git-core/ppa -y

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
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
    && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/*

RUN sudo apt-get update && \
    sudo apt-get install -y zsh && \
    sudo rm -rf /var/lib/apt/lists/*

ENV TERM xterm
ENV ZSH_THEME agnoster
ENV SHELL=/usr/bin/zsh

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

CMD [ "zsh" ]
