#!/bin/sh

HERE=$(pwd)
THERE="$HOME/bin"

echo creating symlinks from $HERE to $THERE
mkdir -p $THERE

ln --symbolic $HERE/CopyWithMd5.sh $THERE
ln --symbolic $HERE/CreateSqfsImg.sh $THERE



