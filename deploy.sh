#!/bin/bash

set -e
set -o errexit -o nounset

hugoOutputDir=$1
blogRepoDir=blogDestination

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master. Not deploying."
fi

git clone git@github.com:StephenGregory/stephengregory.github.io.git $blogRepoDir
cp -TR $hugoOutputDir $blogRepoDir
cd $blogRepoDir

git config user.name "Stephen Gregory"
git config user.email "stephengregorynl@gmail.com"

git add -A .
TRAVIS_COMMIT_SHORT=${TRAVIS_COMMIT:0:7} && git commit -m "Travis CI auto-deploy $TRAVIS_REPO_SLUG@$TRAVIS_COMMIT_SHORT"

git push
