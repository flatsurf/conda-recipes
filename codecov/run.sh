#!/bin/bash
set -exo pipefail

# ##################################################################
# Push coverage data to codecov.io
# ##################################################################

# Report for coverage enabled builds
if [[ "$action" != "coverage" ]]; then
  exit 0
fi

# Install gcov
conda install -y --quiet gcc_linux-64

cd $SRC_DIR

git remote remove origin || true
git remote add origin https://github.com/$GITHUB_ORGANIZATION/$GITHUB_REPOSITORY.git
git fetch origin
git checkout -b master
git branch -u origin/master

curl -s https://codecov.io/bash > codecov
chmod +x codecov
./codecov $CODECOV_FLAGS -v -R `pwd` -x `which x86_64-conda_cos6-linux-gnu-gcov` -a '\-lrp' -p .
