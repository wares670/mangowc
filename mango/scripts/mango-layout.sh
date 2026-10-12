#!/bin/bash

mmsg watch all-monitors | jq --unbuffered -r '.monitors[] | select(.active) | .layout_symbol' | while read -r SYM; do
    # Strip any brackets like [S] or []= if the compositor outputs them
    CLEAN_SYM=$(echo "$SYM" | tr -d '[]=' | xargs)

    # Translate the abbreviation to a full word
    case "$CLEAN_SYM" in
        "S"|"scroller")       TEXT="Scroller" ;;
        "T"|"tile"|"")        TEXT="Tiling" ;;
        "M"|"monocle")        TEXT="Monocle" ;;
        "D"|"dwindle")        TEXT="Dwindle" ;;
        "G"|"grid"|"###")     TEXT="Grid" ;;
        "deck")               TEXT="Deck" ;;
        *)                    TEXT="$SYM" ;; # Fallback just in case
    esac

    echo "$TEXT"
done
