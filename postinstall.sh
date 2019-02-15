#!/bin/bash

mkdir /deploy/$APPLICATION_NAME/$DEPLOYMENT_GROUP_NAME
rsync -a /deploy/$APPLICATION_NAME/temp/RAND/  /deploy/$APPLICATION_NAME/$DEPLOYMENT_GROUP_NAME/

case $DEPLOYMENT_GROUP_NAME in
  *"dev")
    DEST="/dev-filer/apps/$APPLICATION_NAME/"
    ;;
  *"uat")
    DEST="/uat-filer/apps/$APPLICATION_NAME/"
    ;;
  *"master"*)
    DEST="/prod-filer/apps/$APPLICATION_NAME/"
    ;;
esac

echo "Dest: $DEST" >> /deploy/$APPLICATION_NAME/$DEPLOYMENT_GROUP_NAME/postinstall.log

mkdir -p $DEST
rsync -au /deploy/$APPLICATION_NAME/$DEPLOYMENT_GROUP_NAME/ $DEST
rm -rf /deploy/$APPLICATION_NAME/temp/RAND
