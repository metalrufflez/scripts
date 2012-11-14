#!/bin/bash

# Set all stderr output to /dev/null
exec 2> /dev/null

WALLPAPERDIR="$HOME/Dropbox/Photos/Wallpapers"

while read file; do 
	WIDTH=$(sips -g pixelWidth "$file" | tail -1 | cut -d" " -f4)
	HEIGHT=$(sips -g pixelHeight "$file" | tail -1 | cut -d" " -f4)

	# Check if the file is a valid image, if not skip
	[ -z "$WIDTH" ] && continue

	echo -n "Moving $file to "

	# Test the ratio against my pre configured ones
	case $(echo "scale=3;$WIDTH / $HEIGHT" | bc) in
		1.333) echo "4:3"
			mv "$file" $WALLPAPERDIR/4x3/
			;;
		1.250) echo "5:4"
			mv "$file" $WALLPAPERDIR/5x4/
			;;
		1.777) echo "16:9"
			mv "$file" $WALLPAPERDIR/16x9/
			;;
		1.600) echo "16:10"
			mv "$file" $WALLPAPERDIR/16x10/
			;;
		*) echo "other_ratio"
			mv "$file" $WALLPAPERDIR/other_ratio/
			;;
	esac
done < <(ls *jpg *jpeg *png *bmp)
