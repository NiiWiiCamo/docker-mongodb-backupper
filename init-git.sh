#!/bin/bash

BASEDIR="/data/${GIT_REPONAME}"

if [[ ! -e ${BASEDIR}/.git ]]
then
  # initialize local git repo
  git config --global init.defaultBranch main
  git init ${BASEDIR}
  cd ${BASEDIR}
  git config user.email "${GIT_USEREMAIL}"
  git config user.name "${GIT_USERNAME}"
  git remote add origin "${GIT_REPOURI}"
fi
