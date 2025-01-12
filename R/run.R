#' Run the Shiny app
#'
#' This function runs the Shiny app that showcases the different features of the Shiny package.
#'
#' @export

run <- function() {
  shiny::runApp(system.file("shiny", "app.R", package = "ShinyShowCase"))
}
