#!/bin/sh

cd godot
sass theme/theme.scss theme/theme.css
godot -s addons/godot-css-theme/convert.gd --input="res://theme/theme.css" --output="res://theme/theme.tres" --headless