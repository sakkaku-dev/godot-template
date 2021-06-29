#!/bin/sh

PLATFORM=$1

if [[ -z $PLATFORM ]]; then
    echo "Platform not specified"
    exit
fi

mkdir -v -p build/$PLATFORM
godot -v --export "$PLATFORM"

if [[ "$PLATFORM" != "mac" ]]; then
    cd build/$PLATFORM && zip -r $PLATFORM.zip *
fi
