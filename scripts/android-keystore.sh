#!/bin/sh

# Generate debug or release keystore for android
# Make sure you password does not contain special linux characters like !
# Example for release: ./android-keystore.sh myGame secretPassword

# If release and "gh" command exist, then it will also setup everything on github for the workflows
# Otherwise it has to be done manually

GAME=$1

function command_exists {
    type "$1" &> /dev/null
}

if [ -z $GAME ]; then
    keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android -keystore debug.keystore -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999 -deststoretype pkcs12
else
    echo -n "Keystore Password: "
    read -s KEY_PASS
    keytool -v -genkey -keystore $GAME.keystore -alias $GAME -storepass "$KEY_PASS" -keyalg RSA -validity 10000

    if [ -f $GAME.keystore ]; then
        if command_exists gh; then
            ENCODED="$(base64 $GAME.keystore -w 0)"
            gh secret set ANDROID_RELEASE_KEYSTORE -b $ENCODED
            gh secret set ANDROID_RELEASE_KEYSTORE_USER -b $GAME
            gh secret set ANDROID_RELEASE_KEYSTORE_PW -b "$KEY_PASS"
        fi
    fi
fi