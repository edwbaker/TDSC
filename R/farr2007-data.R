#' Coding Matrix from Farr (2007)
#'
#' Coding matrix used by Farr (2007).
#'
#' @docType data
#'
#' @usage data(farr2007)
#'
#' @format Matrix
#'
#' @keywords TDSC CodingMatrix
#'
#' @references Farr (2007) “Automated Bioacoustic Identification of Statutory Quarantined Insect Pests”. PhD thesis. University of Hull.
#'
#' @examples
#' library(tuneR)
#' wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
#' data(farr2007)
#' t <- tdsc(wave, coding_matrix=farr2007)
"farr2007"