#!/bin/bash

echo "Checking for config file"
if [ -f "/enigma-bbs/config/config.hjson" ]; then
  echo " - Found config.hjson..."
else
  echo " - No config file found, using basic config..."
  cp /enigma-bbs/misc/config.hjson /enigma-bbs/config/config.hjson
fi

echo "Checking for theme files"
for themefile in menu prompt
do
  if [ -f "/enigma-bbs/config/${themefile}.hjson" ]; then
    echo " - Found ${themefile}.hjson"
  else
    echo " - ${themefile}.hjson not found, copying template..."
    cp /enigma-bbs/misc/${themefile}_template.in.hjson /enigma-bbs/config/${themefile}.hjson
  fi
done