library(shiny)
library(bslib)
library(dplyr)
library(leaflet)
library(leaflet.extras)

# Module UI function
leafletUI <- function(id) {
  ns <- NS(id)

  tagList(
    layout_sidebar(
      sidebar = sidebar(
        title = "Feature Selection",
        radioButtons(ns("map_type"), "Choose a feature:",
                     choices = c("Basic Markers" = "markers",
                                 "Clustered Markers" = "clusters",
                                 "Choropleth Map" = "choropleth",
                                 "Heatmap" = "heatmap",
                                 "Custom Tiles" = "tiles",
                                 "Polylines" = "polylines",
                                 "Circles" = "circles",
                                 "Layer Controls" = "layers"))
      ),

      div(
        class = "d-grid gap-3",
        style = "grid-template-columns: 75% 25%; height: calc(100vh - 160px);",

        # Info column with value boxes
        # Map column
        card(
          height = "100%",
          card_header(
            div(
              class = "d-flex justify-content-between align-items-center",
              textOutput(ns("map_title")),
              actionButton(ns("copy_code"), "Copy Code")
            )
          ),
          leafletOutput(ns("map"), height = "calc(100% - 50px)")
        ),
        div(
          style = "height: 100%;",
          card(
            height = "100%",
            value_box(
              title = "Current Feature",
              value = "Feature description",
              showcase = bsicons::bs_icon("map-fill"),
              theme = "secondary",
              full_screen = TRUE,
              h5(textOutput(ns("map_description")))
            )
          )
        )
      )
    )
  )
}

# Module server function
leafletServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    #source("map_functions.R", local = TRUE)
    #source("map_code.R", local = TRUE)

    current_map <- reactive({
      switch(input$map_type,
             "markers" = create_basic_markers(),
             "clusters" = create_clustered_markers(),
             "choropleth" = create_choropleth(),
             "heatmap" = create_heatmap(),
             "tiles" = create_custom_tiles(),
             "polylines" = create_polylines(),
             "circles" = create_circles(),
             "layers" = create_overlay_layers())
    })

    output$map <- renderLeaflet({
      current_map()
    })

    output$map_title <- renderText({
      switch(input$map_type,
             "markers" = "Basic Markers",
             "clusters" = "Clustered Markers",
             "choropleth" = "Choropleth Map",
             "heatmap" = "Heatmap",
             "tiles" = "Custom Tiles",
             "polylines" = "Polylines",
             "circles" = "Circle Overlays",
             "layers" = "Layer Controls")
    })

    output$map_description <- renderText({
      switch(input$map_type,
             "markers" = "Demonstrates basic marker placement with popups on a map.",
             "clusters" = "Shows how to cluster multiple markers that are close together.",
             "choropleth" = "Displays data values across geographic regions using color intensity.",
             "heatmap" = "Visualizes density of points using a heat map overlay.",
             "tiles" = "Shows different map styles using custom tile providers.",
             "polylines" = "Creates connected lines between points on the map.",
             "circles" = "Adds circular overlays with custom radii and properties.",
             "layers" = "Demonstrates layer controls with different base maps.")
    })

    observeEvent(input$copy_code, {
      clipr::write_clip(map_code[[input$map_type]])
      showNotification("Code copied to clipboard!", type = "message")
    })
  })
}
