#!/bin/sh -eu
# update.sh -- script to bump the upstream version
# Copyright (C) 2017  Olaf Meeuwissen
#
# License: GPL-v3.0+

release=$(curl --silent \
               https://api.github.com/repos/getnikola/nikola/releases/latest \
                 | jq --raw-output '.name' \
                 | sed 's/^v//')
current=$(sed -n "s/^.*_VERSION: \"\([^\"]*\)\".*$/\1/p" .gitlab-ci.yml)

test x$current != x$release || exit 0

if test -z "$(git status --porcelain -- .gitlab-ci.yml)"; then
    sed -i "s/\(_VERSION: \"\)[^\"]*\(\"\)/\1$release\2/" .gitlab-ci.yml
    git commit -m "Bump upstream version" .gitlab-ci.yml
else
    echo "Found uncommitted changes in .gitlab-ci.yml." >&2
    echo "These prevented updating to Nikola $release." >&2
    exit 1
fi
