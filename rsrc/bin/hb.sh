#!/bin/sh

for arg
do
HandBrakeCLI -Z "Apple TV" -i "$arg" -o "`basename "$arg" .avi`.m4v"
done
