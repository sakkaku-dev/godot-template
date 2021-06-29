VERSION=${GODOT_VERSION:-$1}

mkdir -v -p ~/.local/share/godot/templates
mv /root/.local/share/godot/templates/${VERSION}.stable ~/.local/share/godot/templates/${VERSION}.stable