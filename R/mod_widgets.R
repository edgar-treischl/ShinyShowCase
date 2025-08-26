library(shiny)
library(bslib)
library(dplyr)
library(plotly)
library(visNetwork)
library(DT)
library(highcharter)
library(networkD3)
library(d3heatmap)
library(clipr)

# Module UI function
widgetsUI <- function(id) {
  ns <- NS(id)

  tagList(
    layout_sidebar(
      sidebar = sidebar(
        title = "Widget Selection",
        radioButtons(ns("widget_type"), "Choose a widget:",
                     choices = c("3D Plotly" = "plotly",
                                 "Interactive Network" = "network",
                                 "DataTable" = "datatable",
                                 "Highcharts" = "highchart",
                                 "Sankey Diagram" = "sankey",
                                 "Interactive Heatmap" = "heatmap"))
      ),

      div(
        class = "d-grid gap-3",
        style = "grid-template-columns: 75% 25%; height: calc(100vh - 160px);",

        # Visualization column
        card(
          height = "100%",
          card_header(
            div(
              class = "d-flex justify-content-between align-items-center",
              textOutput(ns("widget_title")),
              actionButton(ns("copy_code"), "Copy Code")
            )
          ),
          div(
            style = "height: calc(100% - 50px);",
            uiOutput(ns("widget_output"))
          )
        ),
        # Info column with value boxes
        div(
          style = "height: 100%;",
          card(
            height = "100%",
            value_box(
              title = "Current Widget",
              value = "Widget description",
              showcase = bsicons::bs_icon("tools"),
              theme = "secondary",
              full_screen = TRUE,
              h5(textOutput(ns("widget_description")))
            )
          )
        )
      )
    )
  )
}

# Module server function
widgetsServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    #source("widget_functions.R", local = TRUE)
    #source("widget_code.R", local = TRUE)

    output$widget_output <- renderUI({
      ns <- session$ns
      switch(input$widget_type,
             "plotly" = plotlyOutput(ns("plot_3d"), height = "100%"),
             "network" = visNetworkOutput(ns("network_vis"), height = "100%"),
             "datatable" = DTOutput(ns("dt")),
             "highchart" = highchartOutput(ns("highchart_vis"), height = "100%"),
             "sankey" = sankeyNetworkOutput(ns("sankey_vis"), height = "100%"),
             "heatmap" = d3heatmapOutput(ns("heatmap_vis"), height = "100%"))
    })

    # Render the selected widget
    output$plot_3d <- renderPlotly({ create_plotly_3d() })
    output$network_vis <- renderVisNetwork({ create_network() })
    output$dt <- renderDT({ create_datatable() })
    output$highchart_vis <- renderHighchart({ create_highchart() })
    output$sankey_vis <- renderSankeyNetwork({ create_sankey() })
    output$heatmap_vis <- renderD3heatmap({ create_d3heatmap() })

    output$widget_title <- renderText({
      switch(input$widget_type,
             "plotly" = "Interactive 3D Scatter Plot",
             "network" = "Interactive Network Visualization",
             "datatable" = "Interactive Data Table",
             "highchart" = "Highcharts Time Series",
             "sankey" = "Sankey Diagram",
             "heatmap" = "Interactive Heatmap")
    })

    output$widget_description <- renderText({
      switch(input$widget_type,
             "plotly" = "A 3D scatter plot using plotly, showing the relationships between Iris measurements with interactive tooltips and rotation.",
             "network" = "An interactive network visualization using visNetwork, demonstrating node connections with highlighting and draggable nodes.",
             "datatable" = "An interactive table using DT (DataTables) with sorting, filtering, and pagination capabilities.",
             "highchart" = "A time series visualization using Highcharts with zoom, pan, and tooltip features.",
             "sankey" = "A Sankey diagram showing flow relationships between nodes using networkD3.",
             "heatmap" = "An interactive heatmap with dendrograms using d3heatmap, showing correlations between variables.")
    })

    observeEvent(input$copy_code, {
      clipr::write_clip(widget_code[[input$widget_type]])
      showNotification("Code copied to clipboard!", type = "message")
    })
  })
}
