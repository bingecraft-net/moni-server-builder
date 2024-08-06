#!/usr/bin/env zsh

TARGET_DIR=server
if [[ -d $TARGET_DIR ]] ; then 
  echo target dir $TARGET_DIR already exists
  exit 1
fi

source dependencies.zsh

if [[ -z "$MONI_TEMPLATE" ]] ; then
  echo required MONI_TEMPLATE
  exit 1
fi

if [[ -z "$FORGE_TEMPLATE" ]] ; then
  echo required FORGE_TEMPLATE
  exit 1
fi

if [[ -z "$OVERRIDES_MODS_DIR" ]] ; then
  echo required OVERRIDES_MODS_DIR
  exit 1
fi

if [[ -z "$CI" ]] ; then
  echo "!! OVERRIDE MODS TO BE INSTALLED: !!"
  ls -la $OVERRIDES_MODS_DIR
  if ! read -q "choice?Does it look good? [Y/y] " ; then
    echo
    echo "you said '$choice' so goodbye"
    exit 1
  fi
fi

cp -r $FORGE_TEMPLATE $TARGET_DIR
cp -r $MONI_TEMPLATE/overrides/* $TARGET_DIR
cp -r $OVERRIDES_MODS_DIR/* $TARGET_DIR/mods
cp -r overrides/* $TARGET_DIR

if [[ -f secrets.zsh ]] ; then
  source secrets.zsh
fi

if [[ -z "$DISCORD_TOKEN" ]] ; then
  echo export DISCORD_TOKEN= > secrets.zsh
  chmod +x secrets.zsh

  echo missing env var DISCORD_TOKEN
  echo fill in secrets.zsh and try again
  exit 1
fi

sed -i \
  "s/botToken = \"DiscordIntegration.botToken\"/botToken = \"$DISCORD_TOKEN\"/" \
  server/config/Discord-Integration.toml

