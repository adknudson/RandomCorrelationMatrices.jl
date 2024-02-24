# RandomCorrelationMatrices

[![Build Status](https://travis-ci.org/IainNZ/RandomCorrelationMatrices.jl.svg?branch=master)](https://travis-ci.org/IainNZ/RandomCorrelationMatrices.jl)

Generate random correlation matrices, for some definition of random. Currently supports just one definition/method:

> Lewandowski, Daniel, Dorota Kurowicka, and Harry Joe. "Generating random correlation matrices based on vines and extended onion method." Journal of multivariate analysis 100.9 (2009): 1989-2001. [doi:10.1016/j.jmva.2009.04.008](http://dx.doi.org/10.1016/j.jmva.2009.04.008)

This package has two functions, `randcormatrix(d, η)` and `randcovmatrix(d, η, σ)` . `d` is the dimension, and `η` is a parameter that controls the distribution of the off-diagonal terms. `randcovmatrix` is used to generate a covariance matrix from the output of `randcormatrix`, where the standard deviation of each component is controlled by `σ`.

## Example Usage

To get a feel for how to set `η`, consider the following output, which shows some example matrices and the average range of off-diagonals:

```julia-repl
julia> using Statistics, LinearAlgebra

julia> n = 4; η = 2;

julia> r = randcormatrix(n, η)
4×4 Matrix{Float64}:
  1.0        0.58787   0.27138   -0.105909
  0.58787    1.0       0.281755  -0.107723
  0.27138    0.281755  1.0        0.249834
 -0.105909  -0.107723  0.249834   1.0

julia> s = 1000; ranges = zeros(Float64, s);

julia> for i in 1:s
           r = randcormatrix(n, η)
           r0 = r - Diagonal(r)
           ranges[i] = maximum(r0) - minimum(r0)
        end;

julia> mean(ranges)
0.9431632935736379

julia> median(ranges)
0.944170516935672

julia> η = 32
32

julia> s = 1000; ranges = zeros(Float64, s);

julia> for i in 1:s
           r = randcormatrix(n, η)
           r0 = r - Diagonal(r)
           ranges[i] = maximum(r0) - minimum(r0)
        end;

julia> mean(ranges)
0.3116603248881609

julia> median(ranges)
0.3087574323261617
```

## Contributing

Pull requests welcome for additional methods of generating random correlation matrices that are described in the literature.
