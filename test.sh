#!/bin/sh
# test.sh -- make sure the demo site is minimally functional
# Copyright (C) 2016, 2018  Olaf Meeuwissen
#
# License: GPL-3.0+

nikola init --quiet --demo test
sed -i '/COMMENT_SYSTEM/s/".*/""/' test/conf.py
cd test
nikola build

PORT=8000
nikola serve -d -p $PORT

BASE=http://localhost:$PORT

# Fetch the top page
wget -q $BASE/
rm index.html

# Fetch navbar links
wget -q $BASE/archive.html
wget -q $BASE/categories/index.html
wget -q $BASE/rss.xml
rm index.html

# Fetch top post
wget -q $BASE/posts/welcome-to-nikola/
rm index.html

# Fetch post links
wget -q $BASE/pages/handbook/
rm index.html
wget -q $BASE/galleries/demo/
rm index.html
wget -q $BASE/pages/listings-demo/
rm index.html
wget -q $BASE/pages/dr-nikolas-vendetta/
rm index.html
