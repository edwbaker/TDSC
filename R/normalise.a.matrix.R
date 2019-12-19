#' Normalise an A Matrix
#'
#' Normalises the A Matrix of a tdsc object either by scale or by codewords.
#'
#' @param td A tdsc object
#' @param method Either scale (default) or codewords

#' @export
#' @examples
#' library(tuneR)
#' wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
#' t <- tdsc(wave)
#' t <- normalise.a.matrix(t)
#' t <- normalise.a.matrix(t, method="codewords")
#'
normalise.a.matrix <- function(td, method="scale") {
  if (method=="scale") {
    td@a_matrix <- td@a_matrix / max(td@a_matrix)
    return(td)
  }
  if (method=="codewords") {
    vc <- sum(colSums(!is.na(td@c_matrix)))
    td@a_matrix <- td@a_matrix * drop(100 / vc)
    return(td)
  }
}
