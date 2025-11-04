mapgl::maplibre(center = c(-71.04, 42.36), zoom = 11) |>
  add_allmaps(
    id = "ID",
    url = 'https://annotations.allmaps.org/images/73def4ccb56259d3',
    remove_color = list(color = "#efdecc", threshold = 0.5)
  ) |>
  add_allmaps(
    id = "ID2",
    url = "https://annotations.allmaps.org/maps/a9458d2f895dcdfb"
  )


####
mapgl::maplibre(center = c(-71.04, 42.36), zoom = 11) |>
  registerPlugin(htmltools::htmlDependency(
    name = "test",
    version = "1.0.0",
    src = getwd(),
    script = 'test.js'
  )) |>
  htmlwidgets::onRender(
    "function(el, x) {
      pts(el.map);
    }"
  )


#### ad hoc approach
allmaps_plugin <- htmltools::htmlDependency(
  name = "allmaps",
  version = "1.0.034",
  # src = c(
  # href = 'https://cdn.jsdelivr.net/npm/@allmaps/maplibre@1.0.0-beta.34/dist/bundled/allmaps-maplibre-4.0.umd.js'
  # ),
  src = file.path(getwd(), 'inst/htmlwidgets/lib'),
  script = 'allmaps-maplibre-4.0.umd.js'
)

registerPlugin <- function(map, plugin) {
  map$dependencies <- c(map$dependencies, list(plugin))
  map
}

## notes:
##  - map can be accessed by el.map
##  - to debug: have the map open in a web browser rather than the IDE Viewer
##      - use the browser's developer tools to find what is erroring
##  - need the FULL system path for sources
mapgl::maplibre(center = c(-71.04, 42.36), zoom = 11) |>
  registerPlugin(allmaps_plugin) |>
  htmlwidgets::onRender(
    "function(el, x) {
       el.map.on('render', async () =>{
        el.map.addSource('points-source', {
          'type': 'geojson',
          'data': {
            'type': 'FeatureCollection',
            'features': [
              {
                'type': 'Feature',
                'geometry': {
                  'type': 'Point',
                  'coordinates': [-71.04, 42.36]
                }
              }
            ]
          }
        });

        el.map.addLayer({
          'id': 'point-layer',
          'source': 'points-source',
          'type': 'circle',
          'paint': {
              'circle-radius': 8,
              'circle-color': '#007cbf'
          }
        });
      })
    }"
  ) |>
  htmlwidgets::onRender(
    "function (el, x) {
      el.map.on('load', async () => {
        const warpedMapLayer = new Allmaps.WarpedMapLayer('ID1');
        const annotationURL = 'https://annotations.allmaps.org/images/73def4ccb56259d3';

        el.map.addLayer(warpedMapLayer);
        el.map.moveLayer('ID1', 'point-layer');
        warpedMapLayer.addGeoreferenceAnnotationByUrl(annotationURL);
        warpedMapLayer.setColorize('FF0000');
      })
  }"
  )
