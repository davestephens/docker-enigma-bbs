# Node 6 base image
FROM ubuntu:16.04

MAINTAINER Dave Stephens <dave@force9.org>

# Install some packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    python \
    libssl-dev \
    lrzsz \
    arj \
    lhasa \
    unrar-free \
    p7zip-full \
  && rm -rf /var/lib/apt/lists/*

# install nvm and set node 6
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# needed by nvm install
ENV NVM_DIR /root/.nvm

# install the specified node version and set it as the default one, install pm2
RUN . ~/.nvm/nvm.sh && nvm install 6 && nvm alias default 6 && npm install -g pm2

# clone enig!
RUN git clone https://github.com/NuSkooler/enigma-bbs.git --branch 0.0.8-alpha

# user enigma customisations
VOLUME /mods
VOLUME /misc
VOLUME /art

# enigma storage mounts
VOLUME /enigma-bbs/config
VOLUME /enigma-bbs/db
VOLUME /enigma-bbs/logs
VOLUME /enigma-bbs/mail
VOLUME /enigma-bbs/filebase

# copy base config
COPY config/* /enigma-bbs/misc/

# copy launcher
COPY scripts/* /

WORKDIR /enigma-bbs

# install enig packages
RUN . ~/.nvm/nvm.sh && npm install

# Enigma default port
EXPOSE 8888

# Set the default command
ENTRYPOINT /start.sh
