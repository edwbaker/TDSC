# Plot the A matrix or S Matrix

Plot the A matrix or S Matrix from a tdsc analysis.

## Usage

``` r
tdsc_plot(td, plotter = "persp", ...)
```

## Arguments

- td:

  A TDSC object

- plotter:

  Function used to plot the A matrix (persp or perp3D) or S matrix
  (hist)

- ...:

  Parameters to pass to plotting function

## Examples

``` r
if (FALSE) { # \dontrun{
tdsc.plot(td)
tdsc.plot(td, plotter="persp3D")
tdsc.plot(td, plotter="hist")
} # }
```
