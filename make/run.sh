#!/bin/bash
set -exo pipefail

# ##################################################################
# Run make, make check and friends
# ##################################################################

# Build everything
make CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS"

# Run all test cases
make check CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS" || (cat */test/test-suite*.log; false)

# Run additional tests (might be too slow on non-release builds.)
if [[ "x$build_flavour" == "x" ]]; then
    for subdir in ${SUBDIRS//:/$IFS}; do
        pushd $subdir
        make check-valgrind || (cat test/test-suite*.log; false)
        popd
    done
    make distcheck
fi
