#' TDSC analysis compatible with windowing
#'
#' Wrapper function for TDSC analysis that is compatible with the windowing function
#' of the package sonicscrewdriver.
#'
#' @rdname tdsc.w
#' @param start Start position in samples
#' @param wave Wave object to analyse
#' @param window.length Length of window
#' @export
#' @examples
#' \dontrun{
#' windowing(wave, window.length=1000, window.overlap=0, FUN=tdsc.w)
#' }
tdsc.w <- function(start, wave=NULL, window.length=NULL) {
  remaining <- min(window.length, length(wave) + 1 - start) -1
  w <- sonicscrewdriver::cutws(wave,from=start, to=start+remaining)
  s <- tdsc(w)
  return(s)
}

#' @rdname tdsc.w
#' @export
tdsc.w <- function(start, wave=NULL, window.length=NULL) {
  remaining <- min(window.length, length(wave) + 1 - start) -1
  w <- sonicscrewdriver::cutws(wave,from=start, to=start+remaining)
  s <- tdsc(w)
  return(s)
}
tdsc.w.a <- function(start, wave=NULL, window.length=NULL) {
  remaining <- min(window.length, length(wave) + 1 - start) -1
  w <- sonicscrewdriver::cutws(wave,from=start, to=start+remaining)
  s <- tdsc(w)
  return(s@a_matrix)
}
