# blastn2dotplots

This repository contains the `blastn2dotplots` script and sample data.

## Description
`blastn2dotplots`: A script for visualizing multiple dot-plot alignments from BLASTN output.

## Requirements
This project requires Python 3.8 or higher, along with the following libraries:
- `python 3.8.20`
- `matplotlib 3.7.3`
- `pandas 2.0.3`
- `numpy 1.24.4`

## Installation

Create a new conda environment (optional)
```
conda create -n blastn2dotplots-env python=3.8
conda activate blastn2dotplots-env
```

Install required libraries (if not already installed)
```
conda install matplotlib=3.7.1 numpy=1.24.4 pandas=2.0.3
```

Clone the repository
```
git clone https://github.com/mokuno3430/blastn2dotplots.git
```

Grant execute permission to the script
```
cd blastn2dotplots
chmod u+x blastn2dotplot
```

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


## tips
### preparation files
#### Query and Database Files (Required)
The `-i1` and `-i2` options are used to specify the query and database sequences, respectively. If `-i2` is omitted, the tool automatically treats `-i1` as both the query and database, generating a self-alignment plot.

Subplots are displayed according to the order of sequences in the files:

- **Database sequences** (`-i1`, vertical axis) are arranged from **top to bottom**.
- **Query sequences** (`-i2`, horizontal axis) are arranged from **left to right**.

Each file should be a tab-separated text file with the following format:

- **Minimum required format**:
  - **Column 1:** Sequence ID
   
- **Optional extended formats**:  
  - **Column 1:** Sequence ID
  - **Column 2:** Display name (optional)
  
  or
	
  - **Column 1:** Sequence ID
  - **Column 2:** Display name (optional)
  - **Column 3:** Start position (optional; for adjusting axis scale)
	
  or
	
  - **Column 1:** Sequence ID
  - **Column 2:** Display name (optional)
  - **Column 3:** Start position (optional; shifts the origin of the axis scale)
  - **Column 4:** Orientation (optional; `+` or `-`)

If only the first column (Sequence ID) is needed, these files can be easily generated from the blastn output:
```
cut -f 1 blastn_outfmt6.txt | sort | uniq > query.txt
cut -f 2 blastn_outfmt6.txt | sort | uniq > db.txt
```

#### Highlight regions (Optional)

To highlight specific regions, prepare a tab-delimited file and use either the `--highlight` or `--highlight_crossed` option. The format is the same for both:

- **Column 1:** Sequence ID 
- **Column 2:** Start position (0-based)
- **Column 3:** End position
- **Column 4:** Color code (e.g., `#FF0000` for red)

No header or index is required.
**Example (`highlights.txt`):**
```
plasmid1    5000    15000    #FF9999
```
See Figure 2A and related explanations in the manuscript for more details.

#### Grid lines (Optional)

To add user-defined grid lines, prepare a tab-delimited text file and specify it with the `--manual_grid` option. The file must contain two columns:
- **Column 1:** Sequence ID
- **Column 2:** Position (0-based coordinate)

No header or index is required. This is useful for marking structural variant breakpoints or other specific loci.

**Example (`grids.txt`):**
```
chromosome1    1000000
```

Refer to Figure 2B and the main text for usage details.

### colormap examples
To represent alignment identity, _blastn2dotplots_ supports six built-in colormaps.  
These can be specified using the `--colormap` option.

The default colormap is a rainbow gradient (`--colormap 5`), but users are encouraged to select alternative colormaps—such as those designed for perceptual uniformity or color-blind accessibility—depending on their visualization needs.

Example outputs for each colormap are shown below.

<img src="https://github.com/user-attachments/assets/94447dbe-593e-4e28-ae35-285dc96f25fc" width="500">
