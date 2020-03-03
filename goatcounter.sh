#!/usr/bin/env sh

set -eu

goatcounter serve \
  -automigrate \
  -listen "$GOATCOUNTER_LISTEN" \
  -db "$GOATCOUNTER_DB" \
  -tls none \
  -smtp "smtp://$GOATCOUNTER_SMTP" \
  -auth "email:$GOATCOUNTER_EMAIL"
