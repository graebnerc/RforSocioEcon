#!/bin/bash
convert -density 800 "Einrichtung/wd-structure.pdf" -resize 256x256 "Einrichtung/wd-structure.png"
convert -density 800 "Einrichtung/wd-structure-here.pdf" -resize 256x256 "Einrichtung/wd-structure-here.png"
convert -density 800 "ErsteSchritte/vector-classification.pdf" -resize 1024x1024 "ErsteSchritte/vector-classification.png"
convert -density 800 "A-Markdown/A-Markdown-Ordnerstruktur.pdf" -resize 512x512 "A-Markdown/A-Markdown-Ordnerstruktur.png"
convert -density 800 "Datenaufbereitung/Ordnerstruktur.pdf" -resize 201x274 "Datenaufbereitung/Ordnerstruktur.png"
convert -density 800 "Datenaufbereitung/Skalenniveaus.pdf" -resize 501x374 "Datenaufbereitung/Skalenniveaus.png"



