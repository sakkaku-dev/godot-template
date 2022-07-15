#!/bin/sh

CHANNEL=${CHANNEL:-$1}

mkdir ~/.config
cp /root/.config/godot ~/.config -r
mkdir -v -p build/$CHANNEL
godot -v --export $CHANNEL