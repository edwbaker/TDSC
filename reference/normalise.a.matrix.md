# Normalise an A Matrix

Normalises the A Matrix of a tdsc object either by scale or by
codewords.

## Usage

``` r
normalise.a.matrix(td, method = "scale")
```

## Arguments

- td:

  A tdsc object

- method:

  Either scale (default) or codewords

## Examples

``` r
library(tuneR)
wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
t <- tdsc(wave)
t <- normalise.a.matrix(t)
t <- normalise.a.matrix(t, method="codewords")
```
