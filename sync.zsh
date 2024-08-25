#!/usr/bin/env zsh

TARGET=$1
if [[ -z $TARGET ]] ; then
  echo usage: $0 "<rsync-destination>/"
else
  rsync -avr ./ $TARGET \
    --include 'server/***' \
    --include backup-schedule.zsh \
    --include restore-latest-backup.zsh \
    --include run-accept-eula.zsh \
    --include sync.zsh \
    --exclude '*'
fi
