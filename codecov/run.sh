#!/bin/bash
set -exo pipefail

# ##################################################################
# Push coverage data to codecov.io
# ##################################################################

# Report for coverage enabled builds
if [[ "$action" != "coverage" ]]; then
  exit 0
fi

cd $SRC_DIR

git remote remove origin || true
git remote add origin https://github.com/$GITHUB_ORGANIZATION/$GITHUB_REPOSITORY.git
git fetch origin
git checkout -b master
git branch -u origin/master

curl -s https://codecov.io/bash > codecov
chmod +x codecov

# Delete yaml files that confuse codecov, such as our coverage.yaml
rm -rf **/*.yaml .**/*.yaml || true

set +x
./codecov -R `pwd` -x `which x86_64-conda_cos6-linux-gnu-gcov` -g '**/external/**' -g '**/test/**' -g '**/benchmark/**' -g '**/recipe/**' -a '\-lrp' -p .
