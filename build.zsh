#!/usr/bin/env zsh

MONI_VERSION=0.7.1
MONI_TEMPLATE=moni-server-$MONI_VERSION.zip.d
MONI_ZIP=Monifactory-Alpha.$MONI_VERSION-server.zip
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

OVERRIDES_DIR=overrides
OVERRIDES_MODS_DIR=overrides/mods
mkdir -p $OVERRIDES_MODS_DIR

DI_VERSION=3.0.7.1-1.20.1
DI_JAR=dcintegration-forge-$DI_VERSION.jar
[[ ! -f $OVERRIDES_MODS_DIR/$DI_JAR ]] && {

  curl -sL \
    -o $OVERRIDES_MODS_DIR/$DI_JAR \
    https://cdn.modrinth.com/data/rbJ7eS5V/versions/ILJrSvYW/$DI_JAR

}

ls -la $OVERRIDES_MODS_DIR

TARGET_DIR=server
[[   -d $TARGET_DIR ]] && echo target dir $TARGET_DIR already exists
[[ ! -d $TARGET_DIR ]] && {

  cp -r $FORGE_TEMPLATE $TARGET_DIR
  cp -r $MONI_TEMPLATE/overrides/* $TARGET_DIR
  cp -r $OVERRIDES_DIR/* $TARGET_DIR

  {

    declare -a sedArgs

    while read entry ; do
      key=${entry%%=*}
      value=${entry#*=}
      sedArgs+=("-e")
      sedArgs+=("s|$key|$value|Ig")
    done < secrets.properties

    find server/config -type f | while read file ; do
      sed -i.orig "${sedArgs[@]}" $file
      cmp "$file" "$file.orig" && mv "$file.orig" "$file"
    done

  }

}
