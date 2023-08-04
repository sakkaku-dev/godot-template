#!/bin/sh

VERSION=$1

TARGET=~/.local/share/godot/export_templates/${VERSION}.stable

if [ -f "$TARGET" ]; then
    echo "Templates already installed"
    exit
fi

mkdir -v -p ~/.local/share/godot/export_templates
mv /root/.local/share/godot/export_templates/${VERSION}.stable $TARGET