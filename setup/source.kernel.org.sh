#!/usr/bin/env bash
set -ex
addr=https://cdn.kernel.org/index.html
e1='id="latest_link"'
e2='href="\K[^"]+'
dl=$(curl $addr | grep -A2 "$e1" | grep -oP "$e2")
curl "$dl" | tar -xJ
mv linux-* linux
