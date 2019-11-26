#' Coding Matrix from Chesmore (2001)
#'
#' Coding matrix used for Orthoptera.
#'
#' @docType data
#'
#' @usage data(chesmore2001)
#'
#' @format Matrix
#'
#' @keywords TDSC CodingMatrix
#'
#' @references Chesmore, E David (2001). “Application of time domain signal coding and artificial neural networks to passive acoustical identification of animals”. In: Applied Acoustics 62.12, pp. 1359–1374.
#'
#' @source \href{https://phenome.jax.org/projects/Moore1b}{QTL Archive}
#'
#' @examples
#' library(tuneR)
#' wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
#' data(chesmore2001)
#' t <- tdsc(wave, coding_matrix=chesmore2001)
"chesmore2001"