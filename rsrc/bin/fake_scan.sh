#!/bin/sh

# Cruddify a PDF to look like you printed and scanned it.
# Based on: https://gist.github.com/andyrbell/25c8632e15d17c83a54602f6acde2724

convert -density 150 $1 -rotate "$([ $((RANDOM % 2)) -eq 1 ] && echo -)0.$(($RANDOM % 4 + 5))" -attenuate 0.4 +noise Multiplicative -attenuate 0.03 +noise Multiplicative -sharpen 0x1.0 -colorspace Gray scanned.pdf
