#!/usr/bin/env bash

set -euxo pipefail

puppet parser validate "$REPO"/{modules,code}

puppet-lint --no-documentation-check "$REPO"/{modules,code}

rsync \
  --rsync-path=/usr/bin/openrsync \
  --delete \
  -arv "$REPO" buhman@blackwater.lan:~
