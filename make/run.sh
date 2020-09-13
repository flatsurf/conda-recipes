#!/bin/bash
set -exo pipefail

# ##################################################################
# Run make, make check and friends
# ##################################################################

case $action in
  release)
    make install CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS"
    exit 0
    ;;
  style)
    exit 0
    ;;
  *)
    # Build everything
    make CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS"
esac

case $action in
  test)
    # Run valgrind checks first (might be too slow on non-release builds) so we
    # understand segfaults before they happen in the full testing below.
    TESTDIRS=${SUBDIRS:-.}
    for subdir in ${TESTDIRS//:/$IFS}; do
        pushd $subdir
        if which valgrind; then
            make check-valgrind || (echo | cat `find . -name 'test-suite*.log'` /dev/null; false)
        fi
        popd
    done

    # Run all test cases
    make check CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS" || (cat `find . -name 'test-suite*.log'` /dev/null; false)

    make distcheck || (echo | cat `find . -name test-suite.log` /dev/null; false)
    ;;
  coverage)
    # Run all test cases
    make check CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS" || (cat `find . -name 'test-suite*.log'` /dev/null; false)
    ;;
esac
