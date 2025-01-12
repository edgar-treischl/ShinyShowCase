library(shiny)
library(ggplot2)
library(dplyr)

# Module UI function
ggplotUI <- function(id) {
  ns <- NS(id)

  tagList(
    layout_sidebar(
      sidebar = sidebar(
        title = "Plot Selection",
        radioButtons(ns("plot_type"), "Choose a plot type:",
                    choices = c("Scatter Plot" = "scatter",
                                "Box Plot" = "box",
                                "Density + Histogram" = "density",
                                "Faceted Time Series" = "facet",
                                "Bar Plot" = "bar",
                                "Violin Plot" = "violin",
                                "Heatmap" = "heatmap",
                                "Area Plot" = "area",
                                "Bubble Plot" = "bubble",
                                "Error Bar Plot" = "errorbar"))
      ),

      div(
        class = "d-grid gap-3",
        style = "grid-template-columns: 75% 25%; height: calc(100vh - 160px);",
        card(
          height = "100%",
          card_header(
            div(
              class = "d-flex justify-content-between align-items-center",
              textOutput(ns("plot_title")),
              div(
                class = "d-flex gap-2",
                downloadButton(ns("download_plot"), "Download Plot",
                               class = "btn-primary"),
                actionButton(ns("copy_code"), "Copy Code")
              )
            )),
          plotOutput(ns("plot"), height = "calc(100% - 50px)")
        ),
        div(
          style = "height: 100%;",
          card(
            height = "100%",
            value_box(
              title = "Current Plot",
              value = "Plot description",
              showcase = bsicons::bs_icon("rocket-takeoff"),
              theme = "secondary",
              full_screen = TRUE,
              h5(textOutput(ns("plot_description"))),
              tags$pre(
                id = ns("plot_code"),
                style = "display: none;",
                textOutput(ns("current_code"))
              )
            )
          )
        )
      )
    )
  )
}

# Module server function
ggplotServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    source("plot_functions.R", local = TRUE)
    source("plot_code.R", local = TRUE)

    current_plot <- reactive({
      switch(input$plot_type,
             "scatter" = create_scatter(),
             "box" = create_boxplot(),
             "density" = create_density(),
             "facet" = create_facet(),
             "bar" = create_bar(),
             "violin" = create_violin(),
             "heatmap" = create_heatmap(),
             "area" = create_area(),
             "bubble" = create_bubble(),
             "errorbar" = create_errorbar())
    })

    output$plot <- renderPlot({
      current_plot()
    })

    output$current_code <- renderText({
      plot_code[[input$plot_type]]
    })

    # Copy code using clipr
    observeEvent(input$copy_code, {
      clipr::write_clip(plot_code[[input$plot_type]])
      showNotification("Code copied to clipboard!", type = "message")
    })

    output$plot_title <- renderText({
      switch(input$plot_type,
             "scatter" = "Scatter Plot",
             "box" = "Box Plot",
             "density" = "Density + Histogram",
             "facet" = "Faceted Time Series",
             "bar" = "Bar Plot",
             "violin" = "Violin Plot",
             "heatmap" = "Heatmap",
             "area" = "Area Plot",
             "bubble" = "Bubble Plot",
             "errorbar" = "Error Bar Plot")
    })

    output$download_plot <- downloadHandler(
      filename = function() {
        paste0(input$plot_type, "_plot.png")
      },
      content = function(file) {
        ggsave(file, plot = current_plot(),
               device = "png",
               width = 10,
               height = 7,
               dpi = 300)
      }
    )

    output$plot_description <- renderText({
      switch(input$plot_type,
             "scatter" = "A scatter plot shows how two variables relate by plotting points on a grid.",
             "box" = "A box plot shows the distribution of data, highlighting the median, quartiles, and outliers.",
             "density" = "A density plot shows the distribution of data as a smooth curve, highlighting where values are concentrated.",
             "facet" = "A faceted time series plot showing various US economic indicators over time.",
             "bar" = "A stacked bar plot showing the distribution of vehicle classes by drive type.",
             "violin" = "A violin plot combines a box plot and a density plot, showing data distribution, spread, and potential outliers.",
             "heatmap" = "A heatmap uses color to show the intensity of values in a matrix, making patterns easy to spot.",
             "area" = "An area plot showing US unemployment numbers over time.",
             "bubble" = "A bubble chart is like a scatter plot, but with circles that vary in size to represent an additional data dimension.",
             "errorbar" = "An error bar plot shows data points with bars (lines) indicating the variability or uncertainty in the measurements.")
    })

  })
}
