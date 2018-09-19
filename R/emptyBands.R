#' Empty Bands Discovery
#'
#' Identifies unused codes across multiple S-matricies
#' 
#' @param ... Two or more TDSC objects
#' @keywords TDSC
#' @export
#' @examples
#' library(tuneR)
#' wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
#' t <- tdsc(wave)
#' emptyBands(t,t)
#' 
emptyBands <- function(...) {
  input <- list(...)
  if (length(input) < 2) {
    stop("emptyBands requires two or more TDSC objects")
  }
  x <- c()
  y <- c()
  for (i in 1:length(input)) {
    s_matrix <- input[[i]]@s_matrix
    x <- c(x, rep(i, length(s_matrix)))
    y <- c(y, as.numeric(rownames(s_matrix)))
  }
  uy <- unique(y)
  ay <- 1:max(uy)
  m <- ay[!(ay %in% uy)]
  return(list(missing=m, plot=cbind(x,y)))
}