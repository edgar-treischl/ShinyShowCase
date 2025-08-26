library(shiny)
library(ggplot2)
library(bslib)
library(dplyr)
library(clipr)
# Extension packages
library(ggbeeswarm)
library(ggbump)
library(ggalluvial)
library(ggridges)
library(ggcorrplot)
library(ggmosaic)
library(ggradar)
library(ggwordcloud)

# Module UI function
ggextUI <- function(id) {
  ns <- NS(id)

  tagList(
    layout_sidebar(
      sidebar = sidebar(
        title = "Extension Selection",
        radioButtons(ns("plot_type"), "Choose an extension:",
                     choices = c("Beeswarm plot" = "beeswarm",
                                 "ggbump" = "bump",
                                 "ggalluvial" = "alluvial",
                                 "ggridges" = "ridges",
                                 "ggcorrplot" = "corrplot",
                                 "ggmosaic" = "mosaic",
                                 "ggradar" = "radar",
                                 "ggwordcloud" = "wordcloud"))
      ),

      div(
        class = "d-grid gap-3",
        style = "grid-template-columns: 75% 25%; height: calc(100vh - 160px);",

        # Plot column
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
            )
          ),
          plotOutput(ns("plot"), height = "calc(100% - 50px)")
        ),
        div(
          style = "height: 100%;",
          card(
            height = "100%",
            value_box(
              title = "Current Extension",
              value = "Extension description",
              showcase = bsicons::bs_icon("info-circle-fill"),
              theme = "secondary",
              full_screen = TRUE,
              h5(textOutput(ns("plot_description")))
            )
          )
        )
      )
    )
  )
}

# Module server function
ggextServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    #source("plot_functions.R", local = TRUE)
    #source("plot_code.R", local = TRUE)

    current_plot <- reactive({
      switch(input$plot_type,
             "beeswarm" = create_beeswarm(),
             "bump" = create_bump(),
             "alluvial" = create_alluvial(),
             "ridges" = create_ridges(),
             "corrplot" = create_corrplot(),
             "mosaic" = create_mosaic(),
             "radar" = create_radar(),
             "wordcloud" = create_wordcloud())
    })

    output$plot <- renderPlot({
      current_plot()
    })

    # output$current_code <- renderText({
    #   plot_code[[input$plot_type]]
    # })

    observeEvent(input$copy_code, {
      clipr::write_clip(plot_code[[input$plot_type]])
      showNotification("Code copied to clipboard!", type = "message")
    })

    output$plot_title <- renderText({
      switch(input$plot_type,
             "beeswarm" = "Beeswarm Plot",
             "bump" = "Bump Chart",
             "alluvial" = "Alluvial Diagram",
             "ridges" = "Ridgeline Plot",
             "corrplot" = "Correlation Plot",
             "mosaic" = "Mosaic Plot",
             "radar" = "Radar Chart",
             "wordcloud" = "Word Cloud")
    })

    output$plot_description <- renderText({
      switch(input$plot_type,
             "beeswarm" = "Creates bee swarm plots, which are similar to strip charts or jittered plots but with points aligned in a way that avoids overlapping.",
             "bump" = "Creates bump charts to visualize changes in rank over time.",
             "alluvial" = "Creates alluvial diagrams, which are a type of flow diagram showing changes in categorical data over time or between conditions.",
             "ridges" = "Creates ridgeline plots, which are partially overlapping line plots that create the impression of a mountain range.",
             "corrplot" = "Visualizes correlation matrices with various styles and features.",
             "mosaic" = "Creates mosaic plots for visualizing categorical data and their relationships.",
             "radar" = "Creates radar charts (also known as spider or star charts) for comparing multiple variables.",
             "wordcloud" = "Creates word clouds using ggplot2, with words sized by their frequency or importance.")
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
  })
}
