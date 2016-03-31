# zoon applications paper

A reproducible manuscript describing the `zoon` R package, written in the format of a *Methods in Ecology and Evolution* Applications paper.

The manuscript R-markdown file [ms.Rmd](ms.Rmd) can be compiled into a pdf in RStudio, simply by clicking the 'Knit PDF' button (though you will need to have knitr and its dependencies installed).
If you do not use RStudio to compile the pdf, with citations, use `pandoc --filter pandoc-citeproc -s ms.md -o output/zoon_applications_paper.pdf`.
