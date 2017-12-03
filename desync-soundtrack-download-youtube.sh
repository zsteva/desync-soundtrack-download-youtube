#!/bin/bash

URL="https://www.youtube.com/watch?v=MnIYp-PaoXg&list=PLRtkK6TD_2LLWHeAAYnalSVCXZV0T39vu&index=1"

~/bin/youtube-dl -x -k -o "%(playlist_index)02d. %(title)s - %(id)s.%(ext)s" --audio-format "mp3" --audio-quality 0 "$URL"

for F in *.mp3; do
    ARTIST="Daniel Delux"
    NUM=$(echo "${F}" | sed -e 's/^\([0-9]\+\)\..*$/\1/')
    TITLE=$(echo "${F}" | sed -e 's/^[0-9]\+\.\s*//' -e 's/^\(.\+\) - \(.\+\) - .*$/\2/')
    ALBUM=$(echo "${F}" | sed -e 's/^[0-9]\+\.\s*//' -e 's/^\(.\+\) - \(.\+\) - .*$/\1/')

    id3v2 --artist "$ARTIST" --album "$ALBUM" --song "$TITLE" --TIT3 "$TITLE" --comment "" --year "" --track "$NUM" --genre 255 "$F"
done
