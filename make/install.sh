#!/bin/bash
set -exo pipefail

# ##################################################################
# Run make install, in the same way we ran make
# ##################################################################

make install CXXFLAGS="$CXXFLAGS $EXTRA_CXXFLAGS"
