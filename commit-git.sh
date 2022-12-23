#!/bin/bash

BASEDIR="/data/${GIT_REPONAME}"
CONFDIR="/config/ssh"

cd ${BASEDIR}

if [[ -z ${GIT_REPOURI} || -z ${GIT_USEREMAIL} || -z ${GIT_USERNAME} ]]
then
  echo "to enable remote git repo upload please set the following variables"
  echo "GIT_REPOURI: connection string, e.g. git@github.com:myusername/myproject.git"
  echo "GIT_USEREMAIL: the email you have registered "
fi

if [[ ! -f "/home/abc/.ssh/id*" ]]
then
  echo "copying all ssh keys to home dir"
  mkdir -p /home/abc/.ssh
  cp ${CONFDIR}/id* /home/abc/.ssh
  chmod 700 /home/abc/.ssh
  chmod 600 /home/abc/.ssh/id*
  chmod 644 /home/abc/.ssh/id*.pub
fi

# init local git repo if it doesn't exist already
$(/bin/bash /backupper/init-git.sh)

# pull from git repo to prevent conflicts
git pull origin main

# remove old backups
rm -r ${MONGODB_DATABASE}* 2>/dev/null

# run new backup
$(/bin/bash /backupper/clouddb-backup.sh)

# push to git repo
git add *
git commit -m "rotated backup. check previous commits for older versions."
git push origin main
