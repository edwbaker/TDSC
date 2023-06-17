#' Plot the A matrix or S Matrix
#'
#' Plot the A matrix or S Matrix from a tdsc analysis.
#'
#' @param td A TDSC object
#' @param plotter Function used to plot the A matrix (persp or perp3D)  or S matrix (hist)
#' @param ... Parameters to pass to plotting function
#' @export
#' @examples
#' \dontrun{
#' tdsc.plot(td)
#' tdsc.plot(td, plotter="persp3D")
#' tdsc.plot(td, plotter="hist")
#' }
#'
tdsc_plot <- function(
   td,
   plotter="persp",
   ...
){
  if (plotter=="persp") {
    plot_a_persp(td, ...)
  }
  if (plotter=="persp3D") {
    plot_a_persp3D(td, ...)
  }
  if (plotter=="hist") {
    plot_s_hist(td, ...)
  }
}

plot_a_persp <- function(td, ...) {
  graphics::persp(td@a_matrix,
                  theta = 30, phi = 20,
                  xlab="Code", ylab="Lagged Code", zlab="",
                  ...
                  )
}

plot_a_persp3D <- function(td, ...) {
  package.installed("GA")
  GA::persp3D(x=1:nrow(td@a_matrix),y=1:ncol(td@a_matrix),z=td@a_matrix,
                     xlab="Code", ylab="Lagged Code", zlab="",
                      ...
                     )
}

plot_s_hist <- function(td, ...) {
  graphics::hist(td@codelist,
       xlab="Code",
       main="",
       ...
       )
}
