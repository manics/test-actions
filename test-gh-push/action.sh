#!/bin/sh

set -eux
env
git config -l --global || true
git config -l --local

git branch
git branch -r
git show-ref

if [ -n "${GITHUB_ACTOR:-}" ]; then
    git config --global user.name "$GITHUB_ACTOR"
    git config --global user.email "$GITHUB_ACTOR@users.noreply.github.com"
fi

BRANCH=test-gh-push

echo origin/$BRANCH
git log -5 origin/$BRANCH

git checkout $BRANCH

echo $BRANCH
git log -5

echo "Updating README.txt"
DATE=`date`
echo $DATE >> README.txt
git add README.txt
git commit -m "$DATE"

echo "Pushing origin HEAD:$BRANCH"
git push origin HEAD:$BRANCH
