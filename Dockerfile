FROM phusion/baseimage:0.9.22

MAINTAINER Dave Stephens <dave@force9.org>

# set up home directories
ENV NVM_DIR /root/.nvm
RUN echo /root > /etc/container_environment/HOME

# Do some stuff!
## apt packages
## download and install nvm
## install node 6 and set to default
## clone enig
## install node packages
## package and tmp cleanup
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
  && curl -O https://raw.githubusercontent.com/creationix/nvm/master/install.sh \
  && chmod +x ./install.sh && ./install.sh && rm install.sh \
  && . ~/.nvm/nvm.sh && nvm install 6 && nvm alias default 6 && npm install -g pm2 \
  && git clone https://github.com/NuSkooler/enigma-bbs.git --depth 1 --branch 0.0.8-alpha \
  && cd /enigma-bbs && npm install --only=production \
  && apt-get remove build-essential python libssl-dev git curl -y && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && apt-get clean

# sexyz
COPY bin/sexyz /usr/local/bin

# enigma storage mounts
VOLUME /enigma-bbs/art
VOLUME /enigma-bbs/config
VOLUME /enigma-bbs/db
VOLUME /enigma-bbs/filebase
VOLUME /enigma-bbs/logs
VOLUME /enigma-bbs/mods
VOLUME /mail

# copy base config
COPY config/* /enigma-bbs/misc/

# set up runit launcher
RUN mkdir /etc/service/enigma-bbs
COPY scripts/enigma-bbs.sh /etc/service/enigma-bbs/run
RUN chmod +x /etc/service/enigma-bbs/run

# set up init script
RUN mkdir -p /etc/my_init.d
COPY scripts/10_enigma_config.sh /etc/my_init.d/10_enigma_config.sh
RUN chmod +x /etc/my_init.d/10_enigma_config.sh

# Enigma default port
EXPOSE 8888

WORKDIR /enigma-bbs

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]