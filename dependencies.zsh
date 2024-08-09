#!/usr/bin/env zsh

source versions.zsh

mkdir -p cache

export MONI_TEMPLATE=cache/moni-server-$MONI_VERSION.zip.d
MONI_ZIP=Monifactory-Beta.$MONI_VERSION-server.zip
[[ ! -d $MONI_TEMPLATE ]] && {
  
  [[ ! -a $MONI_ZIP ]] && {
    echo downloading moni server zip
    curl -sL \
      -o $MONI_ZIP \
      https://github.com/ThePansmith/Monifactory/releases/download/$MONI_VERSION/$MONI_ZIP
  }

  unzip -d $MONI_TEMPLATE $MONI_ZIP

  rm $MONI_ZIP

}

export FORGE_TEMPLATE=cache/forge-template-$FORGE_VERSION
[[ ! -d $FORGE_TEMPLATE ]] && {

  FORGE_INSTALLER=forge-installer.jar
  
  [[ ! -a $FORGE_INSTALLER ]] && {
    echo downloading forge installer
    curl -sL \
      -o $FORGE_INSTALLER \
      https://maven.minecraftforge.net/net/minecraftforge/forge/$FORGE_VERSION/forge-$FORGE_VERSION-installer.jar
  }

  java -jar $FORGE_INSTALLER --installServer $FORGE_TEMPLATE

  rm $FORGE_INSTALLER $FORGE_INSTALLER.log

}

export OVERRIDES_MODS_DIR=cache/overrides/mods
mkdir -p $OVERRIDES_MODS_DIR

DI_JAR=dcintegration-forge-$DI_VERSION.jar
[[ ! -f $OVERRIDES_MODS_DIR/$DI_JAR ]] && {

  curl -sL \
    -o $OVERRIDES_MODS_DIR/$DI_JAR \
    https://cdn.modrinth.com/data/rbJ7eS5V/versions/ILJrSvYW/$DI_JAR

}

