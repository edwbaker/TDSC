#' Following Codes
#'
#' Identifies sequences of codes that follow each other from time domain signal analysis, and optionally plots them as a Sankey diagram.
#'
#' @param tdsc A TDSC object
#' @param depth The length of the sequence of codes to search for
#' @param min_code The minimum value of code to include in sequence
#' @param max_code The maximum value of code to include in sequence
#' @param colourCode If plot is alluvial, colour all codes following this code
#' @param plot If "alluvial" plots the found sequences in a river plot
#' @param ... Arguments to pass to the plotting function
#' @keywords TDSC
#' @export
#' @examples
#' \dontrun{
#' library(tuneR)
#' wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
#' t <- tdsc(wave)
#' followingCodes(t)
#' followingCodes(t, colourCode=2,plot="alluvial")
#' }
followingCodes <- function (tdsc,
                             depth=2,
                             min_code=0,
                             max_code=10,
                             colourCode=1,
                             plot=F,
                             ...) {
  codelist <- tdsc@codelist
  fs <- c()
  p <- cbind(min_code:max_code)
  for (i in 1:depth+1) {
    p_found <- c()
    for (j in 1:nrow(p)) {
      for (k in min_code:max_code) {
        v <- codelist
        x <- c(p[j,], k)
        f <- which(rowSums(mapply('==',
                                  data.table::shift(v, type = 'lead', n = 0:(length(x) - 1)),
                                  x)
        ) == length(x))
        if (length(f) > 0) {
          if (i == depth + 1) {
            fs <- rbind(fs, c(x, length(f)))
          }
          p_found <- rbind(p_found,x)
        }
      }
    }
    p <- p_found

  }
  colnames(fs) <- c(paste0(rep("Code", depth+1), 1:(depth+1)), "Freq")

  if (plot=="alluvial") {
    if (!requireNamespace("alluvial", quietly=TRUE)) {
      stop()
    }
    f <- as.data.frame(fs)
    alluvial::alluvial( f[,1:(depth+1)], freq=f$Freq, border=NA,
                        hide = f$Freq < stats::quantile(f$Freq, .50),
                        col=ifelse( f$Code1 == colourCode,
                                    "red", "grey"),
                        ...
    )
  }
  return(fs)
}
