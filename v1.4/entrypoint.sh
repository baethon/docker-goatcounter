#!/usr/bin/env bash

set -eu

migrate_db ()
{
  goatcounter migrate \
    -createdb \
    -db "$GOATCOUNTER_DB" \
    all
}

create_site ()
{
  goatcounter create \
    -domain "$GOATCOUNTER_DOMAIN" \
    -email "$GOATCOUNTER_EMAIL" \
    -password "$GOATCOUNTER_PASSWORD" \
    -db "$GOATCOUNTER_DB"
}

migrate_db

if ! create_site; then
  # stupid way to silence the errors created by the command
  # we should ignore only 'zdb.TX fn: cname: already exists.'
  /bin/true
fi

exec "$@"
