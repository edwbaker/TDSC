#' Convert a coding matrix to a distributed matrix
#'
#' Identifies unused codes across multiple S-matricies
#' 
#' @param input A tdsc object or a matrix
#' @param sf The scaling factor
#' @keywords TDSC
#' @export
#' @examples
#' c2dmatrix()
#' 
c2dmatrix <- function(input, 
                      sf=100
) {
  if (typeof(input) == "S4" & class(input)[[1]] == "tdsc") {
    c_matrix <- t@c_matrix
  } else {
    c_matrix <- input
  }
  for (i in 1:nrow(c_matrix)) {
    for (j in 1:ncol(c_matrix))
      c_matrix[i,j] <- j*sf + i
  }
  return(c_matrix)
}