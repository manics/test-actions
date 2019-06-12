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
REPO=`git remote get-url origin`

echo "git clone -b $BRANCH $REPO $REPO-$BRANCH"
git clone -b $BRANCH $REPO $REPO-$BRANCH
cd $REPO-$BRANCH
git log -5

# echo origin/$BRANCH
# git log -5 origin/$BRANCH

# git checkout -b $BRANCH --track origin/$BRANCH

# echo $BRANCH
# git log -5

echo "Updating README.txt"
DATE=`date`
echo $DATE >> README.txt
git add README.txt
git commit -m "$DATE"

echo "Pushing origin HEAD:$BRANCH"
git push origin HEAD:$BRANCH
