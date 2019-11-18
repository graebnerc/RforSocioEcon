library(bookdown)
library(here)
stat_chap <- here("ChapA-WdhlStatistik1.Rmd")
markdown_chap <- here("ChapA-Markdown.Rmd")
prev_chapter <- here("ChapA-WdhlStatistik1.Rmd")
vis_chap <- here("Chap-visualization.Rmd")
data_chap <- here("Chap-data.Rmd")

preview_chapter(input=vis_chap, output_dir=here("docs"))
