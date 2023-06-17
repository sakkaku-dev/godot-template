#!/bin/sh

CHANNEL=${CHANNEL:-$1}
VERSION=${$2:-dev}

# mkdir ~/.config
# cp /root/.config/godot ~/.config -r
cd godot
mkdir -v -p build/$CHANNEL
godot --export $CHANNEL