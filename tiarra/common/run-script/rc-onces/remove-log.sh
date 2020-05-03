#!/bin/sh
# $Id: remove-log.sh 3004 2007-12-10 12:45:39Z topia $
# copyright (C) 2004 Topia <topia@clovery.jp>. all rights reserved.

LAZY_EXECUTE="${LAZY_EXECUTE}"'
for i in "${REDIR_STDOUT}" "${REDIR_STDERR}"; do
  case "$i" in
    \&*|-) ;;
    *)
      rm -f "${i#>}"
      ;;
  esac
done
'
