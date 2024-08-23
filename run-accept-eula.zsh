#!/bin/zsh

cd server

while ! ./run.sh nogui || grep "You need to agree to the EULA" logs/latest.log ; do
  sed -i s/eula=false/eula=true/ eula.txt
done
