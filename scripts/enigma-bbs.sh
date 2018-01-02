#!/bin/bash
source ~/.nvm/nvm.sh
cd /enigma-bbs
exec pm2-docker /enigma-bbs/main.js
