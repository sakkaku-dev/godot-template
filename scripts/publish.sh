#!/bin/sh

# Deps:
# generate-changelog
# github-cli
# butler

GAME="##VAR_GAME_NAME"
VERSION="$1"

ARGS=("$@")
if [[ ${#ARGS[@]} -lt 2 ]]; then
    echo "No channels"
    exit 0
fi
shift

# win, linux, Web, macOS, android
CHANNELS=( "$@" )
LAST_TAG=$(git describe --tags --abbrev=0)
CHANGELOG=""

generate_changelog() {
    echo "Generating changelog"
    touch package.json
    echo "{}" > package.json
    changelog -p -t $LAST_TAG -f CHANGELOG.md
    CHANGELOG=$(cat CHANGELOG.md)
    rm package.json
    rm CHANGELOG.md
}

build_channels() {
    for CHANNEL in "${CHANNELS[@]}"; do
        echo "Building channel $CHANNEL"
        ./scripts/build-channel.sh $CHANNEL
    done
}

github_release() {
    echo "Releasing version $VERSION to github for $CHANNELS"

    cd godot/build
    mkdir -p gh-releases
    for CHANNEL in "${CHANNELS[@]}"; do
        echo "Archiving $CHANNEL"
        cp $CHANNEL $GAME -r
        zip -r gh-releases/$GAME-$CHANNEL.zip $GAME
        rm $GAME -rf
    done

    echo "Creating release"
    gh release create $VERSION gh-releases/* -n "$CHANGELOG" -t ""
    rm gh-releases -rf
}

itch_release() {
    echo "Releasing version $VERSION to itch.io for $CHANNELS"

    for CHANNEL in "${CHANNELS[@]}"; do
        echo "Releasing $CHANNEL"
        butler push godot/build/$CHANNEL kuma-gee/$GAME:$CHANNEL --userversion $VERSION
    done
}

# sh ./addons/debug/prepare-build.sh $VERSION
build_channels

VERSION_REGEX='^v[0-9]+\.[0-9]+\.[0-9]+(-rc[0-9]+)?$'
if [[ $VERSION =~ $VERSION_REGEX ]]; then
    generate_changelog

    if [[ $VERSION != *"-rc"* ]]; then
        itch_release
    fi

    github_release

else
    echo "Missing or invalid version. Publish skipped."
fi
