#!/bin/sh

CHANNEL=${CHANNEL:-$1}

cd godot
mkdir -v -p ../build/$CHANNEL
godot --export-release --headless $CHANNEL
