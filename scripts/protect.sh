#!/bin/sh

# Protect assets with password
CMD="$1"
ASSET_FOLDER="godot/assets"
FILES=("sound" "sprites" "models" "theme")
COMMANDS=("unpack" "pack")

if [ -z "$CMD" ]; then
    echo "No command provided. Available commands: unpack, pack"
    exit 1
fi

if [[ ! " ${COMMANDS[@]} " =~ " ${CMD} " ]]; then
    echo "Unknown command. Available commands: unpack, pack"
    exit 1
fi


# Read Password
echo -n Password: 
read -s password
echo

if [ "$CMD" == "unpack" ]; then
    cd $ASSET_FOLDER
    for FILE in "${FILES[@]}"; do
        unzip -P $password -d $FILE $FILE.zip
    done
elif [ "$CMD" == "pack" ]; then
    cd $ASSET_FOLDER
    for FILE in "${FILES[@]}"; do
        cd $FILE
        if [ -f "../$FILE.zip" ]; then
            rm ../$FILE.zip
        fi

        zip -e -r ../$FILE.zip * -x "*.import" -9 -P $password
        cd ..
    done
fi
