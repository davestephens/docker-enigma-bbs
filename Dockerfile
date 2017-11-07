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

#needed by nvm install
ENV NVM_DIR /root/.nvm

# install the specified node version and set it as the default one, install pm2
RUN . ~/.nvm/nvm.sh && nvm install 6 && nvm alias default 6 && npm install -g pm2

# clone enig!
RUN git clone https://github.com/NuSkooler/enigma-bbs.git --branch 0.0.8-alpha

# copy config
COPY config/* /enigma-bbs/config
# backup in case user mounts empty config volume
COPY config/* /enigma-bbs/misc

WORKDIR /enigma-bbs

# install enig packages
RUN . ~/.nvm/nvm.sh && npm install

# Enigma default port
EXPOSE 8888

# storage
VOLUME /enigma-bbs/config
VOLUME /enigma-bbs/db
VOLUME /enigma-bbs/logs
VOLUME /enigma-bbs/mail

# Set the default command
ENTRYPOINT . ~/.nvm/nvm.sh && if [ ! -f /enigma-bbs/config/enigma.hjson ]; cp /enigma-bbs/misc/enigma.hjson /enigma-bbs/config/enigma.hjson fi && /enigma-bbs/main.js --config /enigma-bbs/config/enigma.hjson

