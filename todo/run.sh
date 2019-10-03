#!/bin/bash
set -exo pipefail

# ##################################################################
# Make sure the source code contains no unresolved TODOs (these should be
# turned into issues instead.)
# ##################################################################

# Ignore submodules
git submodule foreach git clean -fd
git submodule foreach git reset --hard
git diff --exit-code

# Make sure there's no pending todos
! grep "TO""DO" `git ls-files | grep -v external | grep -v azure-pipelines`
