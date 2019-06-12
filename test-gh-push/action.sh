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
git checkout $BRANCH

DATE=`date`
echo $DATE >> README.txt
git add README.txt
git commit -m "$DATE"
git push origin HEAD:$BRANCH
