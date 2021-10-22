#!/usr/bin/env bash

set -e

export AUTH_PASS_HASH=`htpasswd -b -n admin ${AUTH_PASS} | cut -d":" -f 2`
export PGRST_DB_URI=${DATABASE_URL:-"postgres://app_user:password@db:5432/app_db"}
export PGRST_DB_ANON_ROLE=`echo ${DATABASE_URL}| cut -d':' -f 2 | cut -d'/' -f 3`

rm -f /etc/nginx/nginx.conf

# generate the config file
confd -onetime -backend env

exec $1 