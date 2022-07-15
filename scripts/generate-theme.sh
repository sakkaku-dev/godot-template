#!/bin/sh

sass theme/theme.scss theme/theme.css
godot -s addons/godot-css-theme/convert.gd --input="res://theme/theme.css"