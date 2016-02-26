#!/bin/bash

# run code and compile the ms to pdf

# make directories for the figrues and output, if they don't already exist
mkdir -p figs output

# run the R code to create the main figure
Rscript code/workflow_schematic.R

# compile the manuscript using pandoc & latex
pandoc -s --template=tex_template/default.latex -H tex_template/header.tex -V papersize=a4paper ms.md -o output/zoon_applications_paper.pdf
