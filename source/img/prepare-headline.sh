#! /bin/sh -e

if test "$1" = '--help' -o -z "$1"; then echo -n "\
Usage:
  $0 ⟪basename⟫

We’ll take ⟪basename⟫.ready.png and generate three files out of it:

  • ⟪basename⟫.jpg
  • ⟪basename⟫@2x.jpg
  • ⟪basename⟫@preview.png

Dependencies:

  • ImageMagick
"; exit; fi

set -x

convert "$1.ready.png" \
  -resize 1920 \
  -quality 92 \
  "$1.jpg"

convert "$1.ready.png" \
  -resize 3840 \
  -quality 92 \
  "$1@2x.jpg"

convert "$1.jpg" \
  -resize 12x3 \
  "$1@preview.png"
