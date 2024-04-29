#!/usr/bin/env zsh

MONI_TEMPLATE=moni-server-0.2.1.zip.d
[[ ! -d $MONI_TEMPLATE ]] && {

  MONI_SERVER_ZIP=moni-server-0.2.1.zip 
  
  [[ ! -a $MONI_SERVER_ZIP ]] && {
    echo downloading moni server zip
    curl -sL \
      -o $MONI_SERVER_ZIP \
      https://github.com/ThePansmith/Monifactory/releases/download/0.2.1/server.zip
  }

  unzip -d $MONI_TEMPLATE $MONI_SERVER_ZIP

  rm $MONI_SERVER_ZIP

}

FORGE_TEMPLATE=forge-template-1.20.1-47.2.30
[[ ! -d $FORGE_TEMPLATE ]] && {

  FORGE_INSTALLER=forge-installer.jar
  
  [[ ! -a $FORGE_INSTALLER ]] && {
    echo downloading forge installer
    curl -sL \
      -o $FORGE_INSTALLER \
      https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.2.30/forge-1.20.1-47.2.30-installer.jar
  }

  java -jar $FORGE_INSTALLER --installServer forge-template

  rm $FORGE_INSTALLER $FORGE_INSTALLER.log

}

TARGET=server
[[   -d $TARGET ]] && echo target $TARGET already exists
[[ ! -d $TARGET ]] && {
  cp -r $FORGE_TEMPLATE $TARGET
  cp -r $MONI_TEMPLATE/overrides/* $TARGET
}
