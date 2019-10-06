#!/bin/bash
set -exo pipefail

# ##################################################################
# Run make, make check and friends
# ##################################################################

# Style checks finish quickly without any building
if [[ "x$build_flavour" == "xstyle" ]]; then
  exit 0
fi

# Build everything
make CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS"

# Run all test cases
make check CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS" || (cat `find -name 'test-suite*.log'`; false)

# Run additional tests (might be too slow on non-release builds.)
if [[ "x$build_flavour" == "xrelease" ]]; then
    for subdir in ${SUBDIRS//:/$IFS}; do
        pushd $subdir
        make check-valgrind || (cat `find -name 'test-suite*.log'`; false)
        popd
    done
    make distcheck || (cat `find -name test-suite.log`; false)
fi
