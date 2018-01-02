#!/bin/bash

echo "Checking for an ENiGMA config file"
if [ -f "/enigma-bbs/config/config.hjson" ]; then
  echo " - Found config.hjson..."
else
  echo " - No config file found, using basic config..."
  cp /enigma-bbs/misc/config.hjson /enigma-bbs/config/config.hjson
fi