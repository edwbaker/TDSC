#' Plot the A matrix
#'
#' Plot the A matrix from a tdsc analysis.
#'
#' @param td A TDSC object
#' @param plotter Function used to plot the A matrix (persp or perp3D)
#' @export
#' @examples
#' \dontrun{
#' tdsc.plot(td)
#' tdsc.plot(td, plotter="persp3D")
#' }
#'
tdsc.plot <- function(
   td,
   plotter="persp"
){
  if (plotter=="persp") {
    plot.a.persp(td)
  }
  if (plotter=="persp3D") {
    plot.a.persp3D(td)
  }
}

plot.a.persp <- function(td) {
  graphics::persp(td@a_matrix)
}

plot.a.persp3D <- function(td) {
  package.installed("GA")
  GA::persp3D(x=1:nrow(td@a_matrix),y=1:ncol(td@a_matrix),z=td@a_matrix)
}