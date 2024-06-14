#!/bin/zsh
#
cd server

./run.sh nogui

if grep "You need to agree to the EULA" logs/latest.log ; then
  sed -i s/eula=false/eula=true/ eula.txt
fi

while true ; do
  ./run.sh nogui
done
