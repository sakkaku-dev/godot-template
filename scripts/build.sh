#!/bin/sh

PLATFORM=$1
GAME=$2

if [ -z $PLATFORM ]; then
    echo "Platform not specified"
    exit
fi

if [ -z $GAME ] && [ $PLATFORM = 'mac' ]; then
    echo "Game name not specified. Needed for mac build."
    exit
fi


# Needed until using version with https://github.com/godotengine/godot/pull/43621
FILE=$PLATFORM
if [ $PLATFORM = 'web' ]; then
    FILE="index.html"
elif [ $PLATFORM = 'win' ]; then
    FILE="main.exe"
elif [ $PLATFORM = 'linux' ]; then
    FILE="main.x86_64"
elif [ $PLATFORM = 'mac' ]; then
    FILE="$GAME-mac.zip"
fi

mkdir -v -p build/$PLATFORM
godot -v --export "$PLATFORM" build/$PLATFORM/$FILE
