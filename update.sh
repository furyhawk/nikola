#!/bin/sh -eu
# update.sh -- script to bump the upstream version
# Copyright (C) 2017  Olaf Meeuwissen
#
# License: GPL-v3.0+

version=$(docker run --rm $LAST_IMAGE nikola version --check \
    | sed -n 's/.*Nikola==\([0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\)`.*/\1/p')

test x != x$version || exit 0

sed -i "s/\(_VERSION: \"\)[^\"]*\(\"\)/\1$version\2/" .gitlab-ci.yml

git commit -m "Bump upstream version" .gitlab-ci.yml
