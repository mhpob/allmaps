
<!-- README.md is generated from README.Rmd. Please edit that file -->

# allmaps

<!-- badges: start -->

<!-- badges: end -->

The goal of allmaps is to provide the
[@allmaps/maplibre](https://allmaps.org/docs/packages/maplibre) plugin
to allow the use of georeferenced maps from
[Allmaps](https://allmaps.org/) to the [mapgl R
package](https://walker-data.com/mapgl/index.html).

## Installation

You can install the development version of allmaps from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("mhpob/allmaps")
```

## Example

A basic example:

``` r
library(mapgl)
library(allmaps)

mapgl::maplibre(center = c(-71.04, 42.36), zoom = 11) |>
  allmaps::add_allmaps(
    id = "ID",
    url = 'https://annotations.allmaps.org/images/73def4ccb56259d3'
  )
```
