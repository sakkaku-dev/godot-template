#!/bin/sh

PLATFORM=$1

if [ -z $PLATFORM ]; then
    echo "Platform not specified"
    exit
fi


# Needed until using version with https://github.com/godotengine/godot/pull/43621
FILE=$PLATFORM
if [ $PLATFORM -eq 'web' ]; then
    FILE="index.html"
elif [ $PLATFORM -eq 'win' ]; then
    FILE="main.exe"
elif [ $PLATFORM -eq 'linux' ]; then
    FILE="main.x86_64"
elif [ $PLATFORM -eq 'mac' ]; then
    FILE="mac.zip"
fi

mkdir -v -p build/$PLATFORM
godot -v --export "$PLATFORM" build/$PLATFORM/$FILE
