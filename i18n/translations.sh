#!/bin/sh

mkdir -p i18n

pybabel extract -F i18n/babelrc -k text -k LineEdit/placeholder_text -k tr -k items --no-location -o i18n/messages.pot \
    src i18n/menu

cd i18n

LANGS=(en de)

for LANG in "${LANGS[@]}"; do
	if [[ ! -f $LANG.po ]]; then
		msginit --no-translator --input=messages.pot --locale="$LANG"
	fi

    msgmerge --update --no-fuzzy-matching --backup=none --no-location $LANG.po messages.pot

    msgfmt $LANG.po --check

    msgcmp $LANG.po $LANG.po
done