#' Visualise sampled waveforms
#'
#' Function to genertate images of sampled waveforms with shapes analysed by Time Domain Signal Coding.
#' 
#' @param samples The number of samples
#' @param fig_max_samples When constructing multiple figures this parameter can be used to ensure the plots are of the same size and are aligned
#' @param start_zero If TRUE the waveform starts at zero, if FALSE the zero crossings are between samples
#' @param invert If TRUE the shapes are positive with positive minima, if FALSE shapes are neagtive with negative maxima
#' @param tdsc_shapes If TRUE the shapes correspond to TDSC shapes, if FALSE they resemble sampled sine waves
#' @param limit_y If TRUE the shape fills the plot, if FALSE the complete range of the y axis is plotted (-1 to 1).
#' @param ... Further arguments to pass to plot.
#' 
#' @importFrom graphics plot
#' 
#' @keywords TDSC
#' @export
#' @examples
#' sample_waveform()
#' 
sample_waveform <- function(samples=3,
                            fig_max_samples=NULL,
                            start_zero=TRUE,
                            invert=FALSE,
                            tdsc_shapes=FALSE,
                            limit_y=TRUE,
                            ...
){
  if (tdsc_shapes) {
    form <- c(1,0.5)
  } else {
    form <- c(1,-1)
  }
  
  if (start_zero) {
    start <- 0
  } else {
    start <- -0.05
  }
  
  waveform <- c(start,rep_len(form, samples-2),start)
  
  if (invert) {
    waveform <- waveform * -1
  }
  x_axis <- 1:samples
  if (!start_zero) {
    sampling_points <- x_axis
    x_axis <- x_axis - 0.5
    points <- vector(mode="numeric", length=samples)
    for (i in 1:samples-1){
      m <- waveform[i+1] - waveform[i]
      points[i] <- m*0.5 + waveform[i]
    }
  } else {
    sampling_points <- x_axis
    points <- waveform
  }
  
  if(is.null(fig_max_samples)){
    xlim <- c(0,samples)
  } else {
    xlim <- c(0,fig_max_samples)
  }
  
  if (limit_y) {
    ylim <- c(min(waveform)-0.1, max(waveform)+0.1)
  } else {
    ylim <- c(-1.1,1.1)
  }
  

  do.call(plot, c(list(x=x_axis, y=waveform, type="l", xlim=xlim, ylim=ylim), ...))

  if (start_zero) {
    points(x=sampling_points, y=points, pch=16)
  } else {
    points(x=sampling_points[1:length(sampling_points)-1], y=points[1:length(points)-1], pch=16)
  }
  abline(h=0, col="grey")
  abline(v=sampling_points, col="grey")
}