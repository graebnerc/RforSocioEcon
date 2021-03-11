#' Saves a plot both as pdf and png
save_pdf_png <- function(filename, plot = last_plot(), ...){
  if (substr(filename, nchar(filename)-3, nchar(filename)) == ".pdf"){
    filename_pdf <- filename
    filename_png <- gsub(".pdf", ".png", filename)
  } else if (substr(filename, nchar(filename)-3, nchar(filename)) == ".png"){
    filename_png <- filename
    filename_pdf <- gsub(".png", ".pdf", filename)
  } else{
    filename_pdf <- paste0(filename, ".pdf")
    filename_png <- paste0(filename, ".png")
  }
  ggsave(filename = filename_pdf, plot = plot, ...)
  ggsave(filename = filename_png, plot = plot, ...)
  }
