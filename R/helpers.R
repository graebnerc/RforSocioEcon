#' Saves a plot both as pdf and png
save_pdf_png <- function(filename, plot = last_plot(), ...){
  if (substr(file_name, nchar(file_name)-3, nchar(file_name)) == ".pdf"){
    filename_pdf <- filename
    filename_png <- gsub(".pdf", ".png", file_name)
  } else if (substr(file_name, nchar(file_name)-3, nchar(file_name)) == ".png"){
    filename_png <- filename
    filename_pdf <- gsub(".png", ".pdf", file_name)
  } else{
    filename_pdf <- paste0(filename, ".pdf")
    filename_pdf <- paste0(filename, ".png")
  }

  ggsave(filename = filename_pdf, plot = plot, ...)
  ggsave(filename = filename_png, plot = plot, ...)
  }

save_pdf_png(filename = file_name, height=6, width=8)
