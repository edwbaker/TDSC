# Following Codes

Identifies sequences of codes that follow each other from time domain
signal analysis, and optionally plots them as a Sankey diagram.

## Usage

``` r
followingCodes(
  tdsc,
  depth = 2,
  min_code = 0,
  max_code = 10,
  colourCode = 1,
  plot = F,
  ...
)
```

## Arguments

- tdsc:

  A TDSC object

- depth:

  The length of the sequence of codes to search for

- min_code:

  The minimum value of code to include in sequence

- max_code:

  The maximum value of code to include in sequence

- colourCode:

  If plot is alluvial, colour all codes following this code

- plot:

  If "alluvial" plots the found sequences in a river plot

- ...:

  Arguments to pass to the plotting function

## Examples

``` r
if (FALSE) { # \dontrun{
library(tuneR)
wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
t <- tdsc(wave)
followingCodes(t)
followingCodes(t, colourCode=2,plot="alluvial")
} # }
```
