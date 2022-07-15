#!/bin/sh

VERSION=${GODOT_VERSION:-$1}

TARGET=~/.local/share/godot/templates/${VERSION}.stable

if [ -f "$TARGET" ]; then
    echo "Templates already installed"
    exit
fi

mkdir -v -p ~/.local/share/godot/templates
mv /root/.local/share/godot/templates/${VERSION}.stable $TARGET