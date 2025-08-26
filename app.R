library(shiny)
library(bslib)
library(dplyr)
library(echarts4r)

# Source other module files (except landing)

# source("mod_ggplot.R")
# source("mod_ggext.R")
# source("mod_widgets.R")
# source("mod_leaflet.R")
# source("mod_echarts.R")

# Create the main app UI
ui <- page_navbar(
  id = "mainNav",

  theme = bs_theme(bootswatch = "simplex",
                   base_font = font_google("Source Sans Pro")
                   ),
  title = "Shiny Gallery",

  tags$head(
    includeCSS("www/style.css")
  ),

  # Landing page
  nav_panel(
    "Home",
    div(
      # Hero section
      div(
        class = "hero-container",
        div(
          class = "hero-content",
          h1(class = "hero-title", "Shiny Gallery"),
          p(class = "hero-description",
            "Explore different visualization libraries and their capabilities with R and shiny"),
          div(
            class = "hero-buttons",
            actionButton("goto_ggplot", "ggplot2", class = "btn-lg btn-primary me-2"),
            actionButton("goto_ggext", "Extensions", class = "btn-lg btn-secondary me-2"),
            actionButton("goto_widgets", "HTML Widgets", class = "btn-lg btn-success me-2"),
            actionButton("goto_leaflet", "Maps", class = "btn-lg btn-info me-2"),
            actionButton("goto_echarts", "ECharts", class = "btn-lg btn-warning")
          )
        )
      ),

      # Cards section
      div(
        class = "cards-section",
        div(
          class = "cards-header text-center mb-5",
          h2("Available Visualizations"),
          p(class = "cards-description",
            "Our gallery example visualization and libraries for shiny apps.")
        ),

        div(
          class = "cards-container",

          # ggplot2 card
          card(
            class = "card-clickable",
            onclick = "document.getElementById('goto_ggplot').click()",
            card_header(
              "The ggplot2 package",
              class = "text-center"
            ),
            div(
              class = "card-image-container",
              img(
                src = "https://ggplot2.tidyverse.org/logo.png",
                class = "card-image"
              )
            ),
            card_body(
              "Explore the grammar of graphics with ggplot2's extensive visualization capabilities.",
              class = "text-center"
            )
          ),

          # ggplot extensions card
          card(
            class = "card-clickable",
            onclick = "document.getElementById('goto_ggext').click()",
            card_header(
              "Extensions of ggplot2",
              class = "text-center"
            ),
            div(
              class = "card-image-container",
              img(
                src = "/www/ridgeline.png",
                class = "card-image"
              )
            ),
            card_body(
              "Discover powerful extensions that enhance ggplot2's functionality.",
              class = "text-center"
            )
          ),

          # HTML Widgets card
          card(
            class = "card-clickable",
            onclick = "document.getElementById('goto_widgets').click()",
            card_header(
              "HTML Widgets",
              class = "text-center"
            ),
            div(
              class = "card-image-container",
              img(
                src = "www/map.png",
                class = "card-image"
              )
            ),
            card_body(
              "Interactive JavaScript visualizations in R.",
              class = "text-center"
            )
          ),

          # Leaflet card
          card(
            class = "card-clickable",
            onclick = "document.getElementById('goto_leaflet').click()",
            card_header(
              "Interactive Maps",
              class = "text-center"
            ),
            div(
              class = "card-image-container",
              img(
                src = "www/map.png",
                class = "card-image"
              )
            ),
            card_body(
              "Create interactive maps and spatial visualizations with leaflet.",
              class = "text-center"
            )
          ),

          # ECharts card
          card(
            class = "card-clickable",
            onclick = "document.getElementById('goto_echarts').click()",
            card_header(
              "ECharts",
              class = "text-center"
            ),
            div(
              class = "card-image-container",
              img(
                src = "https://echarts4r.john-coene.com/reference/figures/logo.png",
                class = "card-image"
              )
            ),
            card_body(
              "An Open Source JavaScript Visualization Library.",
              class = "text-center"
            )
          )
        )
      ),

      # Footer
      tags$footer(
        class = "app-footer",
        p(class = "footer-text", "Shiny Gallery | Made with ❤️ and created with Shiny")
      )
    )
  ),

  # Main visualization panels
  nav_panel("ggplot2", ggplotUI("ggplot_module")),
  nav_panel("Extensions", ggextUI("ggext_module")),
  nav_panel("HTML Widgets", widgetsUI("widgets")),
  nav_panel("Maps", leafletUI("leaflet")),
  nav_panel(
    title = "ECharts",
    div(
      class = "echarts-container",
      echartsUI("echarts_demo")
    )
  )
)

# Server
server <- function(input, output, session) {
  # Navigation handlers for all buttons
  observeEvent(input$goto_ggplot, {
    updateNavbarPage(session, "mainNav", selected = "ggplot2")
  })

  observeEvent(input$goto_ggext, {
    updateNavbarPage(session, "mainNav", selected = "Extensions")
  })

  observeEvent(input$goto_widgets, {
    updateNavbarPage(session, "mainNav", selected = "HTML Widgets")
  })

  observeEvent(input$goto_leaflet, {
    updateNavbarPage(session, "mainNav", selected = "Maps")
  })

  observeEvent(input$goto_echarts, {
    updateNavbarPage(session, "mainNav", selected = "ECharts")
  })

  # Call other module servers
  ggplotServer("ggplot_module")
  ggextServer("ggext_module")
  widgetsServer("widgets")
  leafletServer("leaflet")
  echartsServer("echarts_demo")
}

# Run the app
shinyApp(ui, server)
