# Create example maps for different leaflet features
create_basic_markers <- function() {
  leaflet() %>%
    addTiles() %>%
    setView(lng = -0.1276, lat = 51.5074, zoom = 12) %>%
    addMarkers(
      lng = c(-0.1276, -0.1167, -0.1357),
      lat = c(51.5074, 51.5167, 51.5223),
      popup = c("London Eye", "Kings Cross", "Regent's Park")
    )
}

create_clustered_markers <- function() {
  set.seed(123)
  df <- data.frame(
    lng = rnorm(100, -0.1276, 0.05),
    lat = rnorm(100, 51.5074, 0.05)
  )

  leaflet(df) %>%
    addTiles() %>%
    setView(lng = -0.1276, lat = 51.5074, zoom = 11) %>%
    addMarkers(
      clusterOptions = markerClusterOptions(),
      popup = "Clustered Point"
    )
}

create_choropleth <- function() {
  states <- sf::st_as_sf(maps::map("state", fill = TRUE, plot = FALSE))
  states$population <- sample(100000:1000000, nrow(states))

  pal <- colorNumeric("viridis", domain = states$population)

  leaflet(states) %>%
    addTiles() %>%
    setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%
    addPolygons(
      fillColor = ~pal(population),
      fillOpacity = 0.7,
      weight = 1,
      color = "#333333",
      popup = ~paste0(states$ID, "<br>Population: ", population)
    ) %>%
    addLegend(
      position = "bottomright",
      pal = pal,
      values = ~population,
      title = "Population"
    )
}

create_heatmap <- function() {
  set.seed(123)
  df <- data.frame(
    lng = rnorm(1000, -0.1276, 0.05),
    lat = rnorm(1000, 51.5074, 0.05),
    intensity = runif(1000, 0, 100)
  )

  leaflet(df) %>%
    addTiles() %>%
    setView(lng = -0.1276, lat = 51.5074, zoom = 11) %>%
    addHeatmap(
      lng = ~lng,
      lat = ~lat,
      intensity = ~intensity,
      blur = 20,
      max = 100,
      radius = 15
    )
}

create_custom_tiles <- function() {
  leaflet() %>%
    addProviderTiles("CartoDB.DarkMatter") %>%
    setView(lng = 2.3522, lat = 48.8566, zoom = 12) %>%
    addMarkers(
      lng = 2.3522,
      lat = 48.8566,
      popup = "Paris"
    )
}

create_polylines <- function() {
  route <- data.frame(
    lng = c(-0.1276, 2.3522, 4.8357, 12.4964),
    lat = c(51.5074, 48.8566, 45.4408, 41.9028),
    city = c("London", "Paris", "Milan", "Rome")
  )

  leaflet() %>%
    addTiles() %>%
    setView(lng = 4, lat = 47, zoom = 5) %>%
    addPolylines(
      data = route,
      lng = ~lng,
      lat = ~lat,
      weight = 3,
      color = "red",
      opacity = 0.7
    ) %>%
    addMarkers(
      data = route,
      popup = ~city
    )
}

create_circles <- function() {
  cities <- data.frame(
    lng = c(-0.1276, 2.3522, 4.8357),
    lat = c(51.5074, 48.8566, 45.4408),
    radius = c(10000, 15000, 20000),
    city = c("London", "Paris", "Milan")
  )

  leaflet(cities) %>%
    addTiles() %>%
    setView(lng = 2, lat = 48, zoom = 5) %>%
    addCircles(
      lng = ~lng,
      lat = ~lat,
      radius = ~radius,
      color = "red",
      fillOpacity = 0.3,
      popup = ~city
    )
}

create_overlay_layers <- function() {
  leaflet() %>%
    setView(lng = -0.1276, lat = 51.5074, zoom = 12) %>%
    addTiles(group = "OpenStreetMap") %>%
    addProviderTiles("Stamen.Toner", group = "Toner") %>%
    addProviderTiles("Stamen.Watercolor", group = "Watercolor") %>%
    addLayersControl(
      baseGroups = c("OpenStreetMap", "Toner", "Watercolor"),
      options = layersControlOptions(collapsed = FALSE)
    )
}
