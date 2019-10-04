#!/bin/bash

# ##################################################################
# Source this file to setup environment variables for codecov.io
# uploads
# ##################################################################

oldstate="$(set +o); set -$-"

# /tmp/secrets contains CI-injected credentials until
# https://github.com/conda/conda-build/pull/3753 is ready
set +x
CODECOV_TOKEN=$(source /tmp/secrets || true; echo $CODECOV_TOKEN)

if [ ${#CODECOV_TOKEN} = 36 ];then
  echo "${CODECOV_TOKEN}" > ~/.codecov.token
  export CODECOV_TOKEN=yes
  export CODECOV_FLAGS="-t @$HOME/.codecov.token"
else
  export CODECOV_TOKEN=no
  export CODECOV_FLAGS="-d"
fi

set -vx; eval "$oldstate"
