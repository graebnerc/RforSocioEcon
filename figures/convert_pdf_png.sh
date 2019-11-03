#!/bin/bash
convert -density 150 "wd-structure.pdf" -resize 256x256 "wd-structure.png"
convert -density 200 "vector-classification.pdf" -resize 1024x1024 "vector-classification.png"
convert -density 150 "chap3-data-folder.pdf" -resize 256x256 "chap3-data-folder.pdf"
convert -density 200 "A-Markdown-Ordnerstruktur.pdf" -resize 512x512 "A-Markdown-Ordnerstruktur.pdf"




