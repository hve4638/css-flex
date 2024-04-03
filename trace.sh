#!/bin/bash

TARGET_DIR="$PWD/styles"
EXPORT_FILENAME="style.css"

inotifywait -m -r -e create,delete,modify "$TARGET_DIR" |
while read -r directory event filename; do
    changed_file="$directory$filename"
    
    if [ -f $EXPORT_FILENAME ]; then
        rm $EXPORT_FILENAME
    fi
    find "$TARGET_DIR" -type f -name *.css -exec cat {} + >> "$EXPORT_FILENAME"
    echo "$filename modified. update $EXPORT_FILENAME"
done