#!/bin/bash
pandoc -s -S -V geometry:margin=1in -H response_header.tex response_to_reviewers.md -o response_to_reviewers.pdf

