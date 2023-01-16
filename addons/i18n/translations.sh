#!/bin/sh

DIR="addons/i18n"

pybabel extract -F "$DIR/babelrc" -k text -k LineEdit/placeholder_text -k tr -k items --no-location -o "$DIR/messages.pot" \
    src "$DIR/menu"

cd $DIR

LANGS=(en de)

for LANG in "${LANGS[@]}"; do
	if [[ ! -f $LANG.po ]]; then
		msginit --no-translator --input=messages.pot --locale="$LANG"
	fi

    msgmerge --update --no-fuzzy-matching --backup=none --no-location $LANG.po messages.pot

    msgfmt $LANG.po --check

    msgcmp $LANG.po $LANG.po
done