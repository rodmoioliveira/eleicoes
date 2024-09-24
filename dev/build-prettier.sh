#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

build-prettier() {
  npx -y prettier --write '*.{css,html}'
  npx @biomejs/biome format --write script.js
}

main() {
  build-prettier
}

main
