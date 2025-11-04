// function setAllmapsOpacity(map, opacity) {
//   map.on("load", async () => {
//     warpedMapLayer.setOpacity(opacity)

//   })
// }



// async function allmaps(map, georef_map){
//   // Create the warped map layers
//   let warpedMapLayers = georef_map.map(
//     item => new Allmaps.WarpedMapLayer(item.id)
//   );

//   // Add layer to the map
//   for (let i = 0; i < georef_map.length; i++) {
//     map.addLayer(warpedMapLayers[i], georef_map[i].before_id);
//     await warpedMapLayers[i].addGeoreferenceAnnotationByUrl(georef_map[i].url);

//     // Set optional properties if provided
//     if (georef_map[i].opacity || 
//         georef_map[i].opacity === 0) {
//       warpedMapLayers[i].setOpacity(georef_map[i].opacity);
//     }
//     if (georef_map[i].colorize) {
//       warpedMapLayers[i].setColorize(georef_map[i].colorize);
//     }
//     if (georef_map[i].remove_color) {
//       warpedMapLayers[i].setRemoveColor(
//         {
//           hexColor: georef_map[i].remove_color.color,
//           threshold: georef_map[i].remove_color.threshold,
//           hardness: georef_map[i].remove_color.hardness
//         }
//       );
//     }
//     if (georef_map[i].saturation || 
//           georef_map[i].saturation === 0) {
//       warpedMapLayers[i].setSaturation(georef_map[i].saturation);
//     }
//   }
// }