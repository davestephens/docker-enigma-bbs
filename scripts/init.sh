#!/bin/bash

copy_customisations() {
  directory=$1

  if [ -n "$(ls -A /$directory)" ]; then
    echo " - Found stuff in $directory, copying..."
    cp -r -f /$directory/* /enigma-bbs/$directory
  else
    echo " - No customisations in $directory..."
  fi

}

echo "Copying in user customisations"
copy_customisations mods
copy_customisations art
copy_customisations misc

echo "Creating config directory"
mkdir -p /root/.config/enigma-bbs

echo "Checking for an ENiGMA config file"
if [ -f "/config/config.hjson" ]; then
  echo " - Found config.hjson..."
  cp /config/config.hjson /root/.config/enigma-bbs/config.hjson
else
  echo " - No config file found, using basic config..."
  cp /enigma-bbs/misc/config.hjson /root/.config/enigma-bbs/config.hjson
fi

