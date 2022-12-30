for ASSET in $(find ./assets/ -type f -name '*.ase'); do
    # Skip files that start with _
    FILENAME=$(basename $ASSET)
    if [[ $FILENAME == _* ]]; then
        echo "Skipping asset file $ASSET"
        continue
    fi

    DIR=$(dirname $ASSET)

    echo "Generating sprites for $ASSET"
    aseprite -b \
        --script-param file=$FILENAME \
        --script-param dir=$DIR \
        --script-param col=$1 \
        --script ./scripts/export-layers.lua | jq '.meta.image'
done