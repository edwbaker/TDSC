#' Time Domain Signal Coding
#'
#' Performs Time Domain Signal Coding on a Wave object calculating the S-matrix and  A-matrix.
#' 
#' @param wave A Wave object
#' @param lag The lag used to create the A-matrix
#' @param coding_matrix A matrix used to code the Duration-Shape pairs
#' @param max_D The maximum Duration to code
#' @param plot If TRUE plots the workings of the coding algorithm
#' @keywords TDSC
#' @importFrom graphics abline
#' @importFrom moments skewness
#' @importFrom stats var
#' @export
#' @examples
#' library(tuneR)
#' wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
#' t <- tdsc(wave)
#' t <- tdsc(wave, lag=2, max_D=10)


tdsc <- function(
  wave,
  lag=1L,
  coding_matrix = NULL,
  plot=FALSE,
  max_D=25L
) {
  if (typeof(wave) != "S4" | class(wave) != "Wave") {
    stop("wave must be a Wave object")
  }
  if (!is.numeric(lag) | !(lag == as.integer(lag))) {
    stop("lag must be an integer")
  }
  if (!is.numeric(max_D) | !(max_D == as.integer(max_D))) {
    stop("max_D must be an integer")
  }
  #set max value for epoch shape based on physical limits of epoch duration
  max_S <- floor(max_D/2)+1
  
  #If coding matrix not specified, construct the complete matrix
  if (is.null(coding_matrix)) {
    #coding_matrix assigns a number sequentially to every possible epoch duration-shape combination
    #multip_matrix assigns 0 or 1 to every epoch duration-shape combination 
    coding_matrix <- matrix(data=NA, nrow=max_D, ncol=max_S)
    multip_matrix <- matrix(data=0, nrow=max_D, ncol=max_S)
    current_code <- 1
    for (i in 1:max_D) {
      if (i < 3) {
        coding_matrix[i,1] <- i
        multip_matrix[i,1] <- i
        current_code <- current_code + 1
      } else {
        n <- floor((i-2)/2) + 1
        for (j in 1:n) {
          coding_matrix[i,j] <- current_code
          multip_matrix[i,j] <- 1
          current_code <- current_code + 1
        }
      }
    }
    #Maximum code assigned in the matrix
    max_code <- current_code - 1
  } else {
    max_code <- max(coding_matrix, na.rm=TRUE)
    multip_matrix <- coding_matrix
    multip_matrix[multip_matrix > 0] <- 1
  }
  
  
  #wave@left <- wave@left * - 1
  
  #Get locations of zero-crossings
  az <- which(wave@left == 0) #Actual zeroes
  
  wave@left[az] <- NA         #Prevent double-detection of zero crossings where actual zeroes occur
  zc <- which(diff(sign(wave@left)) != 0) + 1 #+1 places zc at start of sample after crossing, to match real time
  zc <- sort(c(az,zc))
  wave@left[az] <- 0
  
  #Get locations of negative maxima  
  all_maxima <- which(diff(sign(diff(wave@left)))==-2)+1
  is_maxima <- 1:length(wave@left) %in% all_maxima
  is_negative <- wave@left < 0
  neg_maxima <- is_maxima * is_negative
  
  #Get locations of positive minima
  all_minima <- which(diff(sign(diff(wave@left)))==2)+1
  is_minima <- 1:length(wave@left) %in% all_minima
  is_positive <- wave@left > 0
  pos_minima <- is_positive * is_minima
  
  #Plot waveform and located features
  if (plot==TRUE){ 
    plot(wave@left, type="l")
    abline(h=0, col="blue")
    abline(v=zc, col="red")
    abline(v=which(neg_maxima == TRUE), col="green")
    abline(v=which(pos_minima == TRUE), col="purple")
  }
  
  #Create vector for storing the codes of epochs
  v_length <- length(zc)-1
  D_list <-vector(mode="integer", length=v_length)
  S_list <-vector(mode="integer", length=v_length)
  code <- vector(mode="integer", length=v_length)
  positive <- vector(mode="logical", length=v_length)
  negative <- vector(mode="logical", length=v_length)

  stdsc_d <- vector(mode="integer", length=v_length)
  stdsc_s <- vector(mode="integer", length=v_length)
  
  #b_matrix matrix in shape of coding matrix
  b_matrix <- matrix(data=0, nrow=nrow(coding_matrix), ncol=ncol(coding_matrix))
  
  #Populate code vector and b_matrix matrix (loop over epochs)
  for (i in 1:v_length) {
    i1 <- zc[[i]]
    i2 <- zc[[i+1]]
    D <- i2 - i1
    S <- sum(neg_maxima[i1:i2]) + sum(pos_minima[i1:i2])
    stdsc_d[i] <- D
    stdsc_s[i] <- S
    if (sum(wave@left[i1:i2]) > 0) {
      positive[i] <- 1
      negative[i] <- 0
    } else {
      positive[i] <- 0
      negative[i] <- 1
    }
    if (D <= nrow(coding_matrix) & S <= ncol(coding_matrix)+1) {
      b_matrix[D,S+1] <- b_matrix[D,S+1] + (1 * multip_matrix[D,S+1])
      code[i] <- coding_matrix[D, S+1]
      D_list[i] <- D
      S_list[i] <- S
    } else {
      code[i] <- NA
      D_list[i] <- NA
      S_list[i] <- NA
    }
  }
  colnames(b_matrix) <- 0:(ncol(b_matrix) - 1)
  
  codelist <- code
  
  s_matrix <-as.matrix(table(code))
  
  #Create the A-matrix
  a_matrix <- matrix(data=0, nrow=max_code, ncol=max_code)
  #Populate the A-matrix
  for (i in 1:(length(code)-lag)) {
    if (!is.na(code[i]) 
        & !is.na(code[i+lag]) 
        & code[i] < max_code 
        & code[i+lag] < max_code
    ) {
      a_matrix[code[i],code[i+lag]] <- a_matrix[code[i],code[i+lag]] + 1
    }
  }
  
  #STDSC - CHANGE TO GET VALUES FROM WAVE
  positive_minima = stdsc_s * positive
  negative_maxima = stdsc_s * negative
  pm <- pos_minima*wave@left
  nm <- neg_maxima*wave@left
  
  stdsc <- list(
    "meanDuration" = mean(stdsc_d),
    "maxDuration" = max(stdsc_d),
    "varD" = var(stdsc_d),
    "skewD" = skewness(stdsc_d),
    "posMinMean" = mean(positive_minima),
    "posMinMax" = max(positive_minima),
    "posMinVar" = var(positive_minima),
    "posMinSkew" = skewness(positive_minima),
    "negMaxMean" = mean(negative_maxima),
    "negMaxMax" = max(negative_maxima),
    "negMaxVar" = var(negative_maxima),
    "negMaxSkew" = skewness(negative_maxima),
    "maximaMean" = mean(nm),
    "maximaMin" = min(nm),
    "maximaMax" = max(nm),
    "maximaVar" = var(nm),
    "maximaVar" = skewness(nm),
    "minimaMean" = mean(pm),
    "minimaMin" = min(pm),
    "minimaMax" = max(pm),
    "minimaVar" = var(pm),
    "minimaSkew" = skewness(pm)
  )
  
  tdsc <- methods::new("tdsc", 
              raw=cbind(D_list, S_list),
              positive=positive,
              codelist=codelist,
              c_matrix=coding_matrix,
              b_matrix=b_matrix,
              s_matrix=s_matrix, 
              a_matrix=a_matrix,
              epoch_count=length(zc) -1,
              sample_count=length(wave@left),
              stdsc=stdsc
  )
  
  return(tdsc)
}