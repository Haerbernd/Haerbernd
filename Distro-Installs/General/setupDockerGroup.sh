#!/bin/sh

if [ "$(echo $USER)" = "root" ]; then
  echo "You can't execute this script as root! Please run it as user"
  exit 1
fi

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
