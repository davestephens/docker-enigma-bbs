#!/bin/bash

copy_customisations() {
  directory=$1

  if [ -n "$(ls -A /$directory)" ]; then
    echo "Found stuff in $directory, copying..."
    cp -r -f /$directory/* /enigma-bbs/$directory
  else
    echo "No customisations in $directory..."
  fi

}

echo "Copying in user customisations"
copy_customisations mods
copy_customisations art
copy_customisations misc

echo "Checking for an ENiGMA config file"
if [ ! -f "/enigma-bbs/config/enigma.hjson" ]; then
  echo "No config file found, copying basic config..."
  cp /enigma-bbs/misc/enigma.hjson /enigma-bbs/config/enigma.hjson
fi


echo "Starting ENiGMA"
. ~/.nvm/nvm.sh && pm2-docker /enigma-bbs/main.js --node-args="--config /enigma-bbs/config/enigma.hjson"

