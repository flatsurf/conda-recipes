#!/bin/bash

# ##################################################################
# Source this file to setup environment variables for codecov.io
# uploads
# ##################################################################

if [[ "$action" == "coverage" ]]; then
  oldstate="$(set +o); set -$-"
  
  set +x
  if [ ${#CODECOV_TOKEN} != 36 ];then
    echo "CODECOV_TOKEN not set. Not uploading to codecov."
    unset CODECOV_TOKEN
    export CODECOV_FLAGS="-d"
  fi
  
  set -vx; eval "$oldstate"
fi
