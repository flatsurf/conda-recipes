#!/bin/bash

# ##################################################################
# Run ./configure with good defaults within conda-build
# ##################################################################

set -exo pipefail

if [ -z $PREFIX ]; then
        export PREFIX="$ASV_ENV_DIR"
fi

if [ -z $PREFIX ]; then
        echo '$PREFIX must be set. Aborting.'
        false
fi

# Create Makefiles
./bootstrap
./configure --prefix="$PREFIX" CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" CXX="$CXX" LDFLAGS="$LDFLAGS" CPPFLAGS="$CPPFLAGS" || (cat config.log; exit 1)
