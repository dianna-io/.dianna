#!/usr/bin/env bash

# (dianna) .dianna/run.sh
#
# notes:
#   provisions a new machine

if [ "$(uname)" == "Darwin" ]; then
    ./run-macos.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    ./run-linux.sh
fi
