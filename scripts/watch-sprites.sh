while true; do
    ls _sprites/* | entr -pd ./scripts/combine-sprites.sh;
    sleep 2
done