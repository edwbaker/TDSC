# Convert a coding matrix to a distributed matrix

This function converts a coding matrix of any kind into a distributed
matrix as described in Farr (2007).

## Usage

``` r
c2dmatrix(t, sf = 100)
```

## Arguments

- t:

  A tdsc object or a matrix

- sf:

  The scaling factor

## References

Farr (2007) “Automated Bioacoustic Identification of Statutory
Quarantined Insect Pests”. PhD thesis. University of York.

## Examples

``` r
c2dmatrix(as.matrix(c(1,2,3,4), nrow=2))
#>      [,1]
#> [1,]  101
#> [2,]  102
#> [3,]  103
#> [4,]  104
```
