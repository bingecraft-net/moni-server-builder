#!/bin/zsh
cd server && ./run.sh nogui ; cd -
if grep "You need to agree to the EULA" server/logs/latest.log ; then
  sed -i s/eula=false/eula=true/ server/eula.txt
  cd server && ./run.sh nogui
fi
