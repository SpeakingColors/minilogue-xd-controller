#!/bin/sh
# Runs the pure C++ core tests against this repo's map.
cd "$(dirname "$0")/.." && c++ -std=c++17 -Wall -Wextra -o "${TMPDIR:-/tmp}/core_test" tests/test_core.cpp && "${TMPDIR:-/tmp}/core_test" map/params.csv
