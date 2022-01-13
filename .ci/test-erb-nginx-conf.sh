#!/bin/bash

# exit on error
set -euo pipefail

export LC_ALL=C
apt-get -qy update
apt-get -qy install ruby

cd $(dirname $0)

# test erb syntax
( erb -P -x -T '-'  servers.conf.erb  | ruby -c ) || exit $?

# test nginx syntax
export URL_STANDUP="${URL_STANDUP:-http://test}"
export PORT=${PORT:-80}
erb servers.conf.erb > /etc/nginx/conf.d/servers.conf

nginx -t -c /etc/nginx/nginx.conf 2>&1 || exit $?

echo "Test OK"
