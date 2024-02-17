#!/bin/sh

CHANNEL=${CHANNEL:-$1}
DEBUG=$2

cd godot
mkdir -v -p ../build/$CHANNEL

if [[ $DEBUG -eq 1 ]]; then 
    godot --export-debug --headless $CHANNEL
else
    godot --export-release --headless $CHANNEL
fi
