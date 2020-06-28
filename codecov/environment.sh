#!/bin/bash

# ##################################################################
# Source this file to setup environment variables for codecov.io
# uploads
# ##################################################################

if [[ "$target" == "coverage" ]]; then
  oldstate="$(set +o); set -$-"
  
  set +x
  if [ ${#CODECOV_TOKEN} = 36 ];then
    echo "${CODECOV_TOKEN}" > ~/.codecov.token
    export CODECOV_TOKEN=yes
    export CODECOV_FLAGS="-t @$HOME/.codecov.token"
  else
    echo "CODECOV_TOKEN not set. Not uploading to codecov."
    export CODECOV_TOKEN=no
    export CODECOV_FLAGS="-d"
  fi
  
  set -vx; eval "$oldstate"
fi
