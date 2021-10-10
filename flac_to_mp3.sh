#!/bin/bash

# Convert a FLAC to MP3 and preserve the metadata tags
album="$(metaflac --show-tag=album "$1" | sed 's/[^=]*=//')"
artist="$(metaflac --show-tag=artist "$1" | sed 's/[^=]*=//')"
date="$(metaflac --show-tag=date "$1" | sed 's/[^=]*=//')"
title="$(metaflac --show-tag=title "$1" | sed 's/[^=]*=//')"
year="$(metaflac --show-tag=date "$1" | sed 's/[^=]*=//')"
tracknumber="$(metaflac --show-tag=tracknumber "$1" | sed 's/[^=]*=//')"

# Variable bitrate (V0) is -V 0
# Constant bitrate 320 is -b 320, -q 0 sets highest quality encoding
# but -q 2 is "high quality" setting
if [ "$MP3_ENCODE" == "V0" ]; then
    ENCODE="-V 0"
elif [ "$MP3_ENCODE" == "320" ]; then
    ENCODE="-b 320 -q 2"
else
    echo "Unrecognized MP3_ENCODE: '$MP3_ENCODE' or not set. Select V0 or 320"
    exit 1
fi

lame $ENCODE \
    --add-id3v2 \
    --tt "$title" \
    --ta "$artist" \
    --tl "$album" \
    --ty "$year" \
    --tn "$tracknumber" \
    "$1"

