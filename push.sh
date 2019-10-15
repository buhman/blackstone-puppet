#!/usr/bin/env bash

set -euxo pipefail

puppet parser validate "$REPO"/{modules,code}

puppet-lint "$REPO"/{modules,code}

rsync \
  --rsync-path=/usr/bin/openrsync \
  -arv "$REPO" buhman@blackwater.lan:~
