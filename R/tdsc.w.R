tdsc.w <- function(start, wave=NULL, window.length=NULL) {
  remaining <- min(window.length, length(wave) + 1 - start) -1
  w <- cutws(wave,from=start, to=start+remaining)
  s <- tdsc(w)
  return(s)
}

tdsc.w.a <- function(start, wave=NULL, window.length=NULL) {
  remaining <- min(window.length, length(wave) + 1 - start) -1
  w <- cutws(wave,from=start, to=start+remaining)
  s <- tdsc(w)
  return(s@a_matrix)
}