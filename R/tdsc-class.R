#' @export
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
