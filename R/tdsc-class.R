#' An S4 class to hold resuts from TDSC
#'
#' @slot raw Two column vector of Durations and Shapes
#' @slot codelist Vector of sequential epoch codings
#' @slot b_matrix The basic matrix
#' @slot c_matrix The coding matrix
#' @slot s_matrix The S-matrix
#' @slot a_matrix The A-matrix
#' @slot sample_count The number of samples in the waveform
#' @slot epoch_count The number of identified epochs
#' 
#' @export
#' 
setClass("tdsc", 
         slots=list(
           raw="matrix",
           codelist="numeric",
           b_matrix="matrix",
           c_matrix="matrix",
           s_matrix="matrix",
           a_matrix="matrix",
           sample_count="numeric",
           epoch_count="numeric"
         ))
