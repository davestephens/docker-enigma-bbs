FROM mhart/alpine-node:6

MAINTAINER Dave Stephens <dave@force9.org>

# dependencies
RUN apk add --no-cache make gcc g++ python git unrar p7zip curl

# binary packages
# sexyz
ADD https://l33t.codes/outgoing/sexyz /usr/local/bin/
RUN chmod +x /usr/local/bin

# source packages
# lhasa
RUN curl -O https://soulsphere.org/projects/lhasa/lhasa-0.3.1.tar.gz \
    && tar xvf lhasa-0.3.1.tar.gz \
    && cd lhasa-0.3.1 \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf lhasa*

# lrzsz
RUN curl -O https://ohse.de/uwe/releases/lrzsz-0.12.20.tar.gz \
    && tar xvf lrzsz-0.12.20.tar.gz \
    && cd lrzsz-0.12.20 \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf lrzsz*

# clone enig!
RUN git clone https://github.com/NuSkooler/enigma-bbs.git --branch 0.0.8-alpha

WORKDIR /enigma-bbs


# user enigma customisations
VOLUME /mods
VOLUME /misc
VOLUME /config

# enigma storage mounts
VOLUME /enigma-bbs/db
VOLUME /enigma-bbs/logs
VOLUME /enigma-bbs/mail
VOLUME /enigma-bbs/filebase

# copy base config
COPY config/* /enigma-bbs/misc/

# copy launcher
COPY scripts/* /

RUN npm install --production && npm install -g pm2 && rm -rf node_modules/farmhash

# Enigma default port
EXPOSE 8888

# Set the default command
ENTRYPOINT ["/bin/sh", "-c", "/init.sh && exec pm2-docker /enigma-bbs/main.js"]

