#!/bin/bash

# backup folder
BASEDIR="/data"
TARGETDIR="${BASEDIR}/${MONGODB_DATABASE}_$(date +%F_%T)"

# create subdir
mkdir -p ${TARGETDIR}

mongodump --uri=${MONGODB_URI} --out=${TARGETDIR} --gzip --db=${MONGODB_DATABASE} --username=${MONGODB_USER} --password=${MONGODB_PASSWORD}
