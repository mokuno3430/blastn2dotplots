#!/bin/sh

db=db.txt
query=query.txt
blastn=blastn_plasmids.txt
highlight=highlights_core.txt

prefix=figure3A
../../blastn2dotplots -i1 $db -i2 $query \
    --blastn $blastn --min_identity 95 --min_alignlen 200 --figure_size 5 5 \
    --highlight_crossed $highlight \
    --show_grid \
    --left_edge 0.12 --right_edge 0.95 \
    --out $prefix 1> log.${prefix}
