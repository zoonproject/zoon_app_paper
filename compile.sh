#!/bin/bash

pandoc -s --template=tex_template/default.latex -H tex_template/header.tex -V papersize=a4paper ms.md -o output/zoon_applications_paper.pdf
