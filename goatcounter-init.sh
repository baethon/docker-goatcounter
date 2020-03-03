#!/usr/bin/env bash

set -eu

printf "Creating site with following options:\n"
printf "\tdomain: %s\n" "$GOATCOUNTER_DOMAIN"
printf "\temail: %s\n" "$GOATCOUNTER_EMAIL"

goatcounter create \
  -domain "$GOATCOUNTER_DOMAIN" \
  -email "$GOATCOUNTER_EMAIL" \
  -db "$GOATCOUNTER_DB"

printf "\nDone!"
