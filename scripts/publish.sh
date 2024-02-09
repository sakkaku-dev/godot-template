#!/bin/sh

# Deps:
# github-cli: for github
# butler: for itchio
# steamcmd: for steam

GAME="##VAR_GAME_NAME"
VERSION="$1"
PLATFORM="$2"
USER="$3"

# win, linux, web, macOS, android
CHANNELS=("web" "linux" "win" "macOS")
LAST_TAG=$(git describe --tags --abbrev=0)
CHANGELOG=""

# run `npm i` before to install dependencies
generate_changelog() {
    echo "Generating changelog"
    npm run changelog
    CHANGELOG=$(cat CHANGELOG.md)
    rm CHANGELOG.md
}

build_channels() {
    for CHANNEL in "${CHANNELS[@]}"; do
        echo "Building channel $CHANNEL"
        rm build/$CHANNEL -rf
        ./scripts/build-channel.sh $CHANNEL
    done
}

github_release() {
    echo "Releasing version $VERSION to github"

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
    echo "Releasing version $VERSION to itch.io"

    for CHANNEL in "${CHANNELS[@]}"; do
        echo "Releasing $CHANNEL"
        butler push build/$CHANNEL $USER/$GAME:$CHANNEL --userversion $VERSION
    done
}

steam_release() {
    echo "Releasing version $VERSION to steam"
    steamcmd +login $USER +run_app_build "$(pwd)/scripts/steam_build.vdf" +quit

    # Enable if game has a demo
    # steamcmd +login $STEAM_USER +run_app_build "$(pwd)/scripts/steam_build_demo.vdf" +quit
}

VERSION_REGEX='^v[0-9]+\.[0-9]+\.[0-9]+(-rc[0-9]+)?$'
if [[ $VERSION =~ $VERSION_REGEX ]]; then
    sh ./scripts/prepare-build.sh $VERSION
    build_channels
    generate_changelog

    if [[ "$PLATFORM" == "steam" ]]; then
        steam_release
    elif [[ "$PLATFORM" == "itch" ]]; then
        itch_release
    else
        github_release
    fi

else
    build_channels
    echo "Missing or invalid version. Publish skipped."
fi
