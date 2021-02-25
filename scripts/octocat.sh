#!/bin/bash

REPO=https://api.github.com/repos/sammyne/gcc-arm

if [ -z $TAG ]; then
  echo "-----------------"
  echo "missing release's TAG :("
  echo "-----------------"
  exit -1
fi

# 9.2-2019.12
curl -H "Accept: application/vnd.github.v3+json" $REPO/releases/tags/$TAG

url=$(curl -H "Accept: application/vnd.github.v3+json" $REPO/releases/tags/$TAG |\
  grep '"upload_url": ' |\
  head -n1              |\
  awk -F'"' '{print $4}'
)

# https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-output-parameter
echo "upload url goes as '$url'"

if [ -z $url ]; then
  echo "---------------------------------------------"
  echo "fail to get 'upload_url' for release's TAG :("
  echo "---------------------------------------------"
  exit -1
fi

echo "::set-output name=upload_url::$url"
