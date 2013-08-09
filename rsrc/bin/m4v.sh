#!/bin/sh

for infile
do
    of=`basename "$infile"`.m4v
    ffmpeg -i "$infile" -vcodec copy -acodec aac -ac 2 -ar 48000 -ab 192k -strict -2 "$of"
done
