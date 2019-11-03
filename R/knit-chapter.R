library(bookdown)
library(here)
stat_chap <- here("ChapA-WdhlStatistik1.Rmd")
markdown_chap <- here("ChapA-Markdown.Rmd")
prev_chapter <- here("ChapA-WdhlStatistik1.Rmd")

preview_chapter(input=markdown_chap, output_dir=here("docs"))
