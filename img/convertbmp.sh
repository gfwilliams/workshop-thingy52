#!/bin/bash

for BMP in `ls *.bmp`; do
PNG=`basename $BMP .bmp`.png
echo "$BMP => $PNG"
convert $BMP -interpolate Nearest -filter point -resize 400% $PNG
done
