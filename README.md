# blastn2dotplots

This repository contains the `blastn2dotplots` script and sample data.



## Requirements
This project requires Python 3.8 or higher, along with the following libraries:
- `python 3.8.20`
- `matplotlib 3.7.3`
- `pandas 2.0.3`
- `numpy 1.24.4`

## Description
`blastn2dotplots`: A script for visualizing multiple dot-plot alignments from BLASTN output.

## Usage
```
usage: blastn2dotplot [-h] -i1 str [-i2 str] --blastn str [--out str]
                      [--highlight str] [--highlight_crossed str]
                      [--min_identity int] [--min_alignlen int] [--line_width float]
                      [--share] [--manual_grid str] [--show_grid] [--grid_color str]
                      [--xtitle_rotate int] [--ytitle_rotate int]
                      [--font_size float] [--figure_size float float]
                      [--hspace float] [--wspace float] [--h_alpha float]
                      [--tick_label_size float] [--tick_width int]
                      [--left_edge float] [--right_edge float] [--top_edge float] [--bottom_edge float]
                      [--colormap {0,1,2,3,4,5}] [-v]
                      
```

## Options
```
  -h, --help            show this help message and exit
  -i1, --input1 str     sequence IDs of database at blastn (=row)
  -i2, --input2 str     sequence IDs of query at blastn (=column)
  --blastn str          blastn.tsv (-outfmt '6 std qlen slen' at blastn)
  --out str             Optional: prefix of pdf file (default out)
  --highlight str       Optional: positions.tsv (scaffold start end color)
  --highlight_crossed str
                        Optional: positions.tsv (scaffold start end color)
  --min_identity int    Optional: minimum sequence identity (default 90)
  --min_alignlen int    Optional: minimum alignment length (default 100)
  --line_width float    Optional: line width of dotplots (default 1.0)
  --share               Optional: sharing axis scales among subplots.
  --manual_grid str     Optional: positions.tsv (scaffold position)
  --show_grid           Optional: show grid-line
  --grid_color str      Optional: grid color (default grey)
  --xtitle_rotate int   Optional: (default 0)
  --ytitle_rotate int   Optional: (default 90)
  --font_size float     Optional: (default 8)
 --figure_size float float
                        Optional: Specify figure size as two numbers >= 3 (default: [8, 8]).
  --hspace float        Optional: (default -1 means auto)
  --wspace float        Optional: (default -1 means auto)
  --h_alpha float       Optional: transparency ratio of highlights (float in the range [0, 1]. default 0.3)
  --tick_label_size float
                        Optional: (default 6)
  --tick_width int      Optional: scale width of axis (bp) (default -1 means auto)
  --left_edge float     Optional: the position of the left edge of the subplots, as a fraction of the figure width (float in the range [0, 1]. default
                        0.15)
  --right_edge float    Optional: the position of the right edge of the subplots (float in the range [0, 1]. default 0.95)
  --top_edge float      Optional: the position of the top edge of the subplots (float in the range [0, 1]. default 0.90)
  --bottom_edge float   Optional: the position of the bottom edge of the subplots (float in the range [0, 1]. default 0.10)
  --colormap {0,1,2,3,4,5}
                        Optional: colormap for identity of alignments ( 0:binary, 1:bone_r, 2:inferno_r, 3:hot_r, 4:YlGnBu, 5:original) (default 5)
  -v, --version         show program's version number and exit

```

## Sample Data
The `sample_data` directory contains two datasets that demonstrate the functionality of `blastn2dotplots`. Each dataset includes input files and a `runme.sh` script for generating dot plots.

### Directory Structure:
```
sample_data
├── figure3A
│   ├── blastn_LT-plasmids_shift.txt  # BLASTN alignment results
│   ├── db.txt                        # Database configuration
│   ├── highlights_core.txt           # Highlights configuration
│   ├── query.txt                     # Query sequences configuration
│   └── runme.sh                      # Script to generate the dot plot
└── figure3B
    ├── blastn_mtDNA-vs-numt.txt      # BLASTN alignment results
    ├── db.txt                        # Database configuration
    ├── grids.txt                     # Grid lines configuration
    ├── query.txt                     # Query configuration
    └── runme.sh                      # Script to generate the dot plot
```
### Dataset Details:
#### Figure 3A: Plasmid Comparison
- Visualizes sequence alignments between plasmids.
- Demonstrates the use of `--highlight_crossed` to emphasize overlapping loci.

#### Figure 3B: numt and mtDNA Comparison
- Compares the nuclear mitochondrial insertion (numt) region on *Arabidopsis thaliana* chromosome 2 with mtDNA.
- Demonstrates the use of `--manual_grid` to add user-defined grid lines.

### Usage:
1. Navigate to the dataset directory:
```
cd sample_data/figure3A
```
2. Run the runme.sh script:
```
./runme.sh
```
3. The resulting dot plot will be saved in the same directory as a PDF file.
