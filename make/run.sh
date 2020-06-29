#!/bin/bash
set -exo pipefail

# ##################################################################
# Run make, make check and friends
# ##################################################################

if [[ "$action" == "style" ]]; then
  exit 0
fi

# Build everything
make CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS"

case $action in
  release|style|benchmark) exit 0;
esac

# Run all test cases
make check CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS" || (cat `find . -name 'test-suite*.log'` /dev/null; false)

# Run additional tests (might be too slow on non-release builds.)
if [[ "$target" == "test" ]]; then
    for subdir in ${SUBDIRS//:/$IFS}; do
        pushd $subdir
        make check-valgrind || (echo | cat `find . -name 'test-suite*.log'` /dev/null; false)
        popd
    done
    make distcheck || (echo | cat `find . -name test-suite.log` /dev/null; false)
fi

if [[ $action == "release" ]]; then
    make install CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS"
fi
