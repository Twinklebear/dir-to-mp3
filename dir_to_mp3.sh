#!/bin/bash

find $1 -name "*.flac" -type f -print0 | parallel -q0 flac_to_mp3.sh

