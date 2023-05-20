#!/bin/sh

# Deps:
# generate-changelog
# github-cli
# butler

GAME="##VAR_GAME_NAME"
VERSION=$1
if [[ -z $VERSION ]]; then
   echo "Version missing"
   exit 0
fi

ARGS=("$@")
if [[ ${#ARGS[@]} == 1 ]]; then
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

    cd build
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
        butler push build/$CHANNEL kuma-gee/$GAME:$CHANNEL --userversion $VERSION
    done
}

generate_changelog

sh ./addons/debug/prepare-build.sh
build_channels

if [[ $VERSION != *"-rc"* ]]; then
    itch_release
fi

github_release