#!/bin/sh

PLATFORM=$1

if [ -z $PLATFORM ]; then
    echo "Platform not specified"
    exit
fi

if [ "$PLATFORM" != "mac" ]; then
    cd build/$PLATFORM && zip -r $PLATFORM.zip *
fi