#!/bin/sh
# Runs the pure C++ core tests against this repo's map.
cd "$(dirname "$0")/.." && c++ -std=c++17 -Wall -Wextra -o "${TMPDIR:-/tmp}/core_test" tests/test_core.cpp && "${TMPDIR:-/tmp}/core_test" map/params.csv
# addresses checked against Korg's minilogue xd MIDI Implementation rev 1.01
grep -q '^cc_93,.*Delay On/Off' map/params.csv && grep -q '^cc_94,.*Reverb On/Off' map/params.csv && grep -q '^cc_106,.*Delay Depth' map/params.csv \
 && grep -q '^cc_108,.*Reverb Time' map/params.csv && grep -q '^nrpn_0_16,.*Voice Mode Type' map/params.csv \
 && ! grep -q -E '^cc_(52|95|112|114|115),' map/params.csv && echo "minilogue map spot checks passed" || { echo "minilogue map spot check FAILED"; exit 1; }
