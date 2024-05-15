#!/usr/bin/env zsh

MONI_VERSION=0.2.6
MONI_TEMPLATE=moni-server-$MONI_VERSION.zip.d
[[ ! -d $MONI_TEMPLATE ]] && {

  MONI_SERVER_ZIP=moni-server-$MONI_VERSION.zip 
  
  [[ ! -a $MONI_SERVER_ZIP ]] && {
    echo downloading moni server zip
    curl -sL \
      -o $MONI_SERVER_ZIP \
      https://github.com/ThePansmith/Monifactory/releases/download/$MONI_VERSION/server.zip
  }

  unzip -d $MONI_TEMPLATE $MONI_SERVER_ZIP \
    -x 'overrides/mods/citresewn-1.20.1-5.jar'

  rm $MONI_SERVER_ZIP

}

FORGE_VERSION=1.20.1-47.2.32
FORGE_TEMPLATE=forge-template-$FORGE_VERSION
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

TARGET=server
[[   -d $TARGET ]] && echo target $TARGET already exists
[[ ! -d $TARGET ]] && {
  cp -r $FORGE_TEMPLATE $TARGET
  cp -r $MONI_TEMPLATE/overrides/* $TARGET
}
