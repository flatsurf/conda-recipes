#!/bin/bash

# ##################################################################
# Source this file to setup environment variables for airspeed
# velocity
# ##################################################################

if [[ "$target" == "benchmark" ]];then
  oldstate="$(set +o); set -$-"
  
  # /tmp/secrets contains CI-injected credentials until
  # https://github.com/conda/conda-build/pull/3753 is ready
  set +x
  ASV_SECRET_KEY=$(source /tmp/secrets || true; echo $ASV_SECRET_KEY)
  
  # Currently, we are assuming that we only run on azure
  export CI=azure
  
  # We publish test results in an Airspeed Velocity database if we have the necessary credentials
  # Note that ASV_SECRET_KEY must have been generated with ssh-keygen -t rsa -m pem
  # otherwise the old ssh implementation used here won't be able to make sense of it
  mkdir -p ~/.ssh
  
  if echo "$ASV_SECRET_KEY" | base64 -d > ~/.ssh/id_rsa; then
    chmod 400 ~/.ssh/id_rsa
    export ASV_SECRET_KEY=yes
    export ASV_GITHUB_REPOSITORY="git@github.com:$GITHUB_ORGANIZATION/$GITHUB_REPOSITORY-asv.git"
  else
    echo "ASV_SECRET_KEY not set. Not uploading to asv repository and GitHub pages."
    export ASV_SECRET_KEY=no
    export ASV_GITHUB_REPOSITORY="https://github.com/$GITHUB_ORGANIZATION/$GITHUB_REPOSITORY-asv.git"
  fi
  
  set -vx; eval "$oldstate"
fi
