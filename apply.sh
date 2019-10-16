#!/usr/bin/env sh

set -eux

puppet apply \
  --modulepath="${REPO}/modules" \
  --codedir="${REPO}/code" \
  --environment=rv \
  "${REPO}/code/environments/rv/manifests/site.pp"
