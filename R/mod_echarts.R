library(shiny)
library(bslib)
library(dplyr)
library(echarts4r)
library(clipr)

# Module UI function
echartsUI <- function(id) {
  ns <- NS(id)

  tagList(
    layout_sidebar(
      sidebar = sidebar(
        title = "Chart Selection",
        radioButtons(ns("chart_type"), "Choose a visualization:",
                     choices = c("3D Surface" = "surface",
                                 "Tree Map" = "treemap",
                                 "Sunburst" = "sunburst",
                                 "Parallel Plot" = "parallel",
                                 "Calendar Heatmap" = "calendar",
                                 "Gauge Chart" = "gauge",
                                 "Word Cloud" = "wordcloud",
                                 "Funnel Chart" = "funnel"))
      ),

      div(
        class = "d-grid gap-3",
        style = "grid-template-columns: 75% 25%; height: calc(100vh - 160px);",
        # Chart column
        card(
          height = "100%",
          card_header(
            div(
              class = "d-flex justify-content-between align-items-center",
              textOutput(ns("chart_title")),
              actionButton(ns("copy_code"), "Copy Code")
            )
          ),
          echarts4rOutput(ns("chart"), height = "calc(100% - 50px)")
        ),
        # Info column with value boxes
        div(
          style = "height: 100%;",
          card(
            height = "100%",
            value_box(
              title = "Current Visualization",
              value = "Chart description",
              showcase = bsicons::bs_icon("graph-up"),
              theme = "secondary",
              full_screen = TRUE,
              h5(textOutput(ns("chart_description")))
            )
          )
        )
      )
    )
  )
}

# Module server function
echartsServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    #source("echarts_functions.R", local = TRUE)
    #source("echarts_code.R", local = TRUE)

    output$chart <- renderEcharts4r({
      switch(input$chart_type,
             "surface" = create_surface(),
             "treemap" = create_treemap(),
             "sunburst" = create_sunburst(),
             "parallel" = create_parallel(),
             "calendar" = create_calendar(),
             "gauge" = create_gauge(),
             "wordcloud" = create_wordcloud(),
             "funnel" = create_funnel())
    })

    output$chart_title <- renderText({
      switch(input$chart_type,
             "surface" = "3D Surface Plot",
             "treemap" = "Hierarchical Treemap",
             "sunburst" = "Sunburst Chart",
             "parallel" = "Parallel Coordinates Plot",
             "calendar" = "Calendar Heatmap",
             "gauge" = "Gauge Chart",
             "wordcloud" = "Word Cloud",
             "funnel" = "Funnel Chart")
    })

    output$chart_description <- renderText({
      switch(input$chart_type,
             "surface" = "3D surface visualization showing relationships between three variables with interactive rotation.",
             "treemap" = "Hierarchical visualization showing nested rectangles sized by value.",
             "sunburst" = "Radial visualization showing hierarchical data in concentric circles.",
             "parallel" = "Multi-dimensional visualization showing relationships across multiple variables.",
             "calendar" = "Time-based heatmap showing data patterns across calendar dates.",
             "gauge" = "Speedometer-like visualization for showing progress or metrics.",
             "wordcloud" = "Text visualization with word size proportional to frequency.",
             "funnel" = "Funnel-shaped visualization showing stages and conversion rates.")
    })

    observeEvent(input$copy_code, {
      clipr::write_clip(echarts_code[[input$chart_type]])
      showNotification("Code copied to clipboard!", type = "message")
    })
  })
}
