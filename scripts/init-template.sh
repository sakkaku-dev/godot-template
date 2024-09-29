GAME_NAME="$1"
REPLACE_TEXT="godot-template"

if [ -z $GAME_NAME ]; then
    echo "Specify game name"
    exit 1
fi

echo "Setting game name to $GAME_NAME"
sed -e "/config\/name/ s/\".*\"/\"$GAME_NAME\"/" -i godot/project.godot
sed -e "/GAME=/ s/\".*\"/\"$GAME_NAME\"/" -i scripts/publish.sh
sed -i "s/GAME: $REPLACE_TEXT/GAME: $GAME_NAME/g" .github/workflows/release.yml
sed -i "s/\"$REPLACE_TEXT\"/\"$GAME_NAME\"/g" package.json

echo "# $GAME_NAME" > README.md
git update-index --assume-unchanged godot/src/env/Build.gd
