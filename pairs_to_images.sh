#!/bin/bash

PATH_PAIRS=/Users/erwan/exjobb/unlabelled_pairs
PATH_MERGED=/Users/erwan/exjobb/merged_pairs

mkdir -p $PATH_MERGED

for DIR in $(ls $PATH_PAIRS); do
    IMAGE0=$(ls $PATH_PAIRS/$DIR/*.png | head -1)
    IMAGE1=$(ls $PATH_PAIRS/$DIR/*.png | tail -1)

    # Just a defensive check that both image names are different
    if [ "$IMAGE0" == "$IMAGE1" ]; then
        echo "ERROR in $DIR!!! [$IMAGE0] [$IMAGE1]"
        exit 1
    fi

    # Generate a new image made of concatenating those two images
    ./merge_images.py --input $IMAGE0 $IMAGE1 --output $PATH_MERGED/$DIR.png
done
