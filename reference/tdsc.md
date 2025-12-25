# Time Domain Signal Coding

Performs Time Domain Signal Coding on a Wave object calculating the
S-matrix and A-matrix.

## Usage

``` r
tdsc(wave, lag = 1L, coding_matrix = NULL, plot = FALSE, max_D = 25L)
```

## Arguments

- wave:

  A Wave object

- lag:

  The lag used to create the A-matrix

- coding_matrix:

  A matrix used to code the Duration-Shape pairs

- plot:

  If TRUE plots the workings of the coding algorithm

- max_D:

  The maximum Duration to code

## Examples

``` r
library(tuneR)
wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
t <- tdsc(wave)
t <- tdsc(wave, lag=2, max_D=10)
```
