#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

validate-site() {
  # https://linuxiac.com/how-to-install-java-on-debian-12-bookworm/
  # https://stackoverflow.com/questions/75608323/how-do-i-solve-error-externally-managed-environment-every-time-i-use-pip-3
  # https://github.com/svenkreiss/html5validator
  if ! html5validator --root . --show-warnings --also-check-css --log INFO; then
    printf "WARN [html5validator] found warnings!\n"
  fi
}

main() {
  validate-site
}

main
