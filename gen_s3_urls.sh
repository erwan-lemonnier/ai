#!/bin/bash

PATH_MERGED=/Users/erwan/exjobb/merged_pairs

for NAME in $(ls $PATH_MERGED); do
    echo "https://s3.eu-central-1.amazonaws.com/chenyang-master-thesis/$NAME"
done
