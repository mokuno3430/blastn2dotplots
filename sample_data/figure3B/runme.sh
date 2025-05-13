#!/bin/sh

db=db.txt
query=query.txt
blastn=blastn_mtDNA-vs-numt.txt
grids=grids.txt

prefix=figure3B
../../blastn2dotplots -i1 $db -i2 $query \
    --blastn $blastn --min_identity 98 --min_alignlen 200 --figure_size 4 5 \
    --manual_grid $grids --tick_width 50000 \
    --grid_color '#00bfff' \
    --left_edge 0.12 --right_edge 0.95 \
    --out $prefix 1> log.${prefix}
