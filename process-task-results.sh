#!/bin/bash

# Extract results and clean then up
echo '' > RESULTS
for FILE in $(ls task-results/results*); do
    cat $FILE | sed -e 's|^.*master-thesis/||' | cut -d ',' -f 1,2 | grep -i png | sed -e 's/\"//g' | cut -d ' ' -f 1 >> RESULTS
done

# The file RESULTS looks like:
# Tina_404_Ian_295.png,Dissimilar
# Tina_404_Ian_295.png,Dissimilar
# Tina_404_Ian_295.png,Similar
# Jamie_693_Kyle_171.png,Dissimilar
# Jamie_693_Kyle_171.png,Similar
# Jamie_693_Kyle_171.png,Dissimilar


# Now filter and keep only similar, respectively dissimilar, names of picture pairs
cat RESULTS | sort | grep Similar | uniq -c | sed -e "s/^\ \ \ //" | egrep -v '^0 ' | egrep -v '^1 ' | cut -d ' ' -f 2 | cut -d ',' -f 1 > SIMILARS
cat RESULTS | sort | grep Dissimilar | uniq -c | sed -e "s/^\ \ \ //" | egrep -v '^0 ' | egrep -v '^1 ' | cut -d ' ' -f 2 | cut -d ',' -f 1 > DISSIMILARS

# Feedback
COUNT_SIM=$(cat SIMILARS | wc -l)
COUNT_DIS=$(cat DISSIMILARS | wc -l)

echo "Found $COUNT_SIM similar pairs"
echo "Found $COUNT_DIS dissimilar pairs"
COUNT_TOTAL=$(($COUNT_SIM + $COUNT_DIS))
echo "Total is $COUNT_TOTAL (should be 5238)"

# Copy similar/dissimilar pairs to a given directory
copy_pairs() {
    TO_DIR=$1
    PAIR_NAMES=$2

    echo "Creating dir $TO_DIR"
    mkdir -p $TO_DIR

    for NAME in $(cat $PAIR_NAMES); do
        echo "Checking name [$NAME]"
        DIRNAME=$(echo "$NAME" | cut -d '.' -f 1)
        echo "Moving [$DIRNAME] to $TO_DIR"
        cp -Rv unlabelled_pairs/$DIRNAME $TO_DIR
    done
}

copy_pairs pairs-similar SIMILARS
copy_pairs pairs-dissimilar DISSIMILARS
