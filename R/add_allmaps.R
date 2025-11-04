allmaps_dependencies <- function() {
  list(
    htmltools::htmlDependency(
      name = "allmaps",
      version = "1.0.034",
      src = system.file("htmlwidgets", "lib", package = "allmaps"),
      script = "allmaps-maplibre-4.0.umd.js"
    )
  )
}

#' @export
add_allmaps <- function(
  map,
  url,
  id,
  opacity = NULL,
  colorize = NULL,
  remove_color = list(
    color = NULL,
    threshold = NULL,
    hardness = NULL
  ),
  saturation = NULL,
  before_id = NULL
) {
  # Register the plugin and bindings
  map$dependencies <- c(map$dependencies, allmaps_dependencies())

  js <- paste0(
    "function(el, x) {
        el.map.on('load', async () => {
          const warpedMapLayer = new Allmaps.WarpedMapLayer(",
    shQuote(id),
    ");
          el.map.addLayer(warpedMapLayer);
          warpedMapLayer.addGeoreferenceAnnotationByUrl(",
    shQuote(url),
    ");",
    if (!is.null(opacity)) {
      paste0("warpedMapLayer.setOpacity(", opacity, ");")
    },
    if (!is.null(colorize)) {
      paste0("warpedMapLayer.setColorize(", shQuote(colorize), ");")
    },
    if (!is.null(saturation)) {
      paste0("warpedMapLayer.setSaturation(", saturation, ");")
    },
    if (!all(sapply(remove_color, is.null))) {
      paste0(
        "warpedMapLayer.setRemoveColor({
          hexColor:",
        shQuote(remove_color$color),
        ",
          threshold:",
        remove_color$threshold %||% "null",
        ",
          hardness:",
        remove_color$hardness %||% "null",
        "
        });"
      )
    },
    "  })
      }"
  )

  map <- map |>
    htmlwidgets::onRender(js)

  map
}
