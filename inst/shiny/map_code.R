map_code <- list(
  markers = 'leaflet() %>%\n  addTiles() %>%\n  setView(lng = -0.1276, lat = 51.5074, zoom = 12) %>%\n  addMarkers(\n    lng = c(-0.1276, -0.1167, -0.1357),\n    lat = c(51.5074, 51.5167, 51.5223),\n    popup = c("London Eye", "Kings Cross", "Regent\'s Park")\n  )',

  clusters = 'df <- data.frame(\n  lng = rnorm(100, -0.1276, 0.05),\n  lat = rnorm(100, 51.5074, 0.05)\n)\n\nleaflet(df) %>%\n  addTiles() %>%\n  setView(lng = -0.1276, lat = 51.5074, zoom = 11) %>%\n  addMarkers(\n    clusterOptions = markerClusterOptions(),\n    popup = "Clustered Point"\n  )',

  choropleth = 'states <- sf::st_as_sf(maps::map("state", fill = TRUE, plot = FALSE))\nstates$population <- sample(100000:1000000, nrow(states))\n\npal <- colorNumeric("viridis", domain = states$population)\n\nleaflet(states) %>%\n  addTiles() %>%\n  setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%\n  addPolygons(\n    fillColor = ~pal(population),\n    fillOpacity = 0.7,\n    weight = 1,\n    color = "#333333",\n    popup = ~paste0(states$ID, "<br>Population: ", population)\n  ) %>%\n  addLegend(\n    position = "bottomright",\n    pal = pal,\n    values = ~population,\n    title = "Population"\n  )',

  heatmap = 'df <- data.frame(\n  lng = rnorm(1000, -0.1276, 0.05),\n  lat = rnorm(1000, 51.5074, 0.05),\n  intensity = runif(1000, 0, 100)\n)\n\nleaflet(df) %>%\n  addTiles() %>%\n  setView(lng = -0.1276, lat = 51.5074, zoom = 11) %>%\n  addHeatmap(\n    lng = ~lng,\n    lat = ~lat,\n    intensity = ~intensity,\n    blur = 20,\n    max = 100,\n    radius = 15\n  )',

  tiles = 'leaflet() %>%\n  addProviderTiles("CartoDB.DarkMatter") %>%\n  setView(lng = 2.3522, lat = 48.8566, zoom = 12) %>%\n  addMarkers(\n    lng = 2.3522,\n    lat = 48.8566,\n    popup = "Paris"\n  )',

  polylines = 'route <- data.frame(\n  lng = c(-0.1276, 2.3522, 4.8357, 12.4964),\n  lat = c(51.5074, 48.8566, 45.4408, 41.9028),\n  city = c("London", "Paris", "Milan", "Rome")\n)\n\nleaflet() %>%\n  addTiles() %>%\n  setView(lng = 4, lat = 47, zoom = 5) %>%\n  addPolylines(\n    data = route,\n    lng = ~lng,\n    lat = ~lat,\n    weight = 3,\n    color = "red",\n    opacity = 0.7\n  ) %>%\n  addMarkers(\n    data = route,\n    popup = ~city\n  )',

  circles = 'cities <- data.frame(\n  lng = c(-0.1276, 2.3522, 4.8357),\n  lat = c(51.5074, 48.8566, 45.4408),\n  radius = c(10000, 15000, 20000),\n  city = c("London", "Paris", "Milan")\n)\n\nleaflet(cities) %>%\n  addTiles() %>%\n  setView(lng = 2, lat = 48, zoom = 5) %>%\n  addCircles(\n    lng = ~lng,\n    lat = ~lat,\n    radius = ~radius,\n    color = "red",\n    fillOpacity = 0.3,\n    popup = ~city\n  )',

  layers = 'leaflet() %>%\n  setView(lng = -0.1276, lat = 51.5074, zoom = 12) %>%\n  addTiles(group = "OpenStreetMap") %>%\n  addProviderTiles("Stamen.Toner", group = "Toner") %>%\n  addProviderTiles("Stamen.Watercolor", group = "Watercolor") %>%\n  addLayersControl(\n    baseGroups = c("OpenStreetMap", "Toner", "Watercolor"),\n    options = layersControlOptions(collapsed = FALSE)\n  )'
)
