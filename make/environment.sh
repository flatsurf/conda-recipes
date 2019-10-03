#!/bin/bash

# ##################################################################
# Source this file to set up flags for make inside conda-build.
# ##################################################################

export MAKEFLAGS="-j$CPU_COUNT"

