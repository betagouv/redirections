#!/bin/bash

set -euo pipefail

DC_TTY=""
test -t 1 || readonly DC_TTY="-T"
cd $(dirname $0)

docker-compose run $DC_TTY --rm check-nginx-conf
