#!/bin/bash

# ##################################################################
# Source this file to set up flags for C/C++ compilers
# correctly inside conda-build.
# It also sets up EXTRA_CXXFLAGS which should be used at
# compile time but will leat to issues at configure time.
# ##################################################################

shopt -s extglob

# Sanitize conda's flags to treat the prefix as system
# headers (and don't report compiler warnings there.)
export CFLAGS=`echo $CFLAGS | sed 's/ -I/ -isystem/g'`
export CPPFLAGS=`echo $CPPFLAGS | sed 's/ -I/ -isystem/g'`
export CXXFLAGS=`echo $CXXFLAGS | sed 's/ -I/ -isystem/g'`

export CPPFLAGS="-isystem ${BUILD_PREFIX}/include $CPPFLAGS"

export CFLAGS="-O2 -g $CXFLAGS"
export CXXFLAGS="-O2 -g $CXXFLAGS"

case `$CXX --version` in
    *GCC*|*gnu-c++*)
        export EXTRA_CXXFLAGS="-Werror -Wall -Wextra -pedantic -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wno-sign-compare -Wdisabled-optimization -Wformat=2 -Winit-self -Wlogical-op -Wmissing-include-dirs -Wold-style-cast -Woverloaded-virtual -Wno-redundant-decls -Wsign-promo -Wstrict-null-sentinel -Wundef -fdiagnostics-show-option -Wconversion -Wshadow-compatible-local -Wno-deprecated -Wno-deprecated-declarations"
        ;;
    *clang*)
        export EXTRA_CXXFLAGS="-Werror -Weverything -Wno-padded -Wno-exit-time-destructors -Wno-undefined-func-template -Wno-global-constructors -Wno-c++98-compat -Wno-missing-prototypes"
        ;;
    *)
        $CXX --version
        echo "Which compiler is this?"
        false;
esac

case `uname` in
    Darwin)
        export EXTRA_CXXFLAGS="$EXTRA_CXXFLAGS -fno-common"
        ;;
esac

if [[ "$action" == "coverage" ]]; then
    export EXTRA_CXXFLAGS="--coverage"
fi

