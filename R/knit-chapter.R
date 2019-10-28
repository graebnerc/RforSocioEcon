library(bookdown)
library(here)
prev_chapter <- here("ChapA-WdhlStatistik1.Rmd")
preview_chapter(input=prev_chapter, output_dir=here("docs"))
