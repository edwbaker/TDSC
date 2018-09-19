#' Convert a coding matrix to a distributed matrix
#'
#' This function converts a coding matrix of any kind into a distributed matrix as described in Farr (2007).
#' 
#' @param t A tdsc object or a matrix
#' @param sf The scaling factor
#' @keywords TDSC
#' @references Farr (2007) “Automated Bioacoustic Identification of Statutory Quarantined Insect Pests”. PhD thesis. University of York.

#' @export
#' @examples
#' c2dmatrix(as.matrix(c(1,2,3,4), nrow=2))
#' 
c2dmatrix <- function(t, 
                      sf=100
) {
  if (typeof(t) == "S4" & class(t)[[1]] == "tdsc") {
    c_matrix <- t@c_matrix
  } else {
    c_matrix <- t
  }
  for (i in 1:nrow(c_matrix)) {
    for (j in 1:ncol(c_matrix))
      c_matrix[i,j] <- j*sf + i
  }
  return(c_matrix)
}