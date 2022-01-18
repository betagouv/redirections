#!/bin/bash

# exit on error
set -euo pipefail

export LC_ALL=C
apt-get -qqqy update
apt-get -qqqy install ruby

cd $(dirname $0)

nginx_servers_erb="servers.conf.erb"
nginx_servers_conf="$(basename $nginx_servers_erb .erb)"

echo "# test $nginx_servers_erb erb syntax"
if [ ! -f "$nginx_servers_erb" ] ; then
    echo "ERROR: $nginx_servers_erb not found"
    exit 1
fi
( erb -P -x -T '-' $nginx_servers_erb | ruby -c ) || exit $?

echo "# generate nginx $nginx_servers_conf file"
# test nginx syntax
export URL_STANDUP="${URL_STANDUP:-http://test}"
export PORT=${PORT:-80}
erb $nginx_servers_erb > /etc/nginx/conf.d/$nginx_servers_conf

echo "# test nginx $nginx_servers_conf syntax"
nginx -t -c /etc/nginx/nginx.conf 2>&1 || exit $?

echo "Test OK"
