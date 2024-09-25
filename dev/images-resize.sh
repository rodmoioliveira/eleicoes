#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

resize-192() {
  printf "Resizing to 192px ...\n"
  paste -d ' ' \
    <(find images/original -type f) \
    <(find images/original -type f | sed -e 's@images/original/@@g' | awk -F'.' '{print "images/192/"$1".webp"}') |
    xargs -n2 -P10 convert -quality 100 -define webp:method=6 -resize 192x
}

resize-300() {
  printf "Resizing to 300px ...\n"
  paste -d ' ' \
    <(find images/original -type f) \
    <(find images/original -type f | sed -e 's@images/original/@@g' | awk -F'.' '{print "images/300/"$1".webp"}') |
    xargs -n2 -P10 convert -quality 100 -define webp:method=6 -resize 300x
}

resize-assert() {
  diff \
    <(find images/original -type f | awk -F'/' '{print $NF}' | awk -F'.' '{print $1}' | sort) \
    <(find images/192 -type f | awk -F'/' '{print $NF}' | awk -F'.' '{print $1}' | sort)

  diff \
    <(find images/original -type f | awk -F'/' '{print $NF}' | awk -F'.' '{print $1}' | sort) \
    <(find images/300 -type f | awk -F'/' '{print $NF}' | awk -F'.' '{print $1}' | sort)
}

main() {
  resize-192
  resize-300
  resize-assert
}

main
