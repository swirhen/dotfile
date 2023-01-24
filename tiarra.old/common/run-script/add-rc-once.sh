#!/bin/sh
# $Id: add-rc-once.sh 3004 2007-12-10 12:45:39Z topia $
# copyright (C) 2004 Topia <topia@clovery.jp>. all rights reserved.

for i in "$@"; do
  echo ". ${i}" >> .tiarrarc-once
done

