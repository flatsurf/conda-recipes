#!/bin/bash
set -exo pipefail

# ##################################################################
# Make sure the source code contains no unresolved TODOs (these should be
# turned into issues instead.)
# ##################################################################

if [[ "$action" != "style" ]]; then
  exit 0
fi

# Ignore submodules
git submodule foreach git clean -fd
git submodule foreach git reset --hard
git diff --exit-code

# Make sure that grep works
grep style `git grep -l ''` > /dev/null

# Make sure there's no pending todos
! grep "TO""DO" `git grep -l ''`
