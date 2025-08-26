# Create example visualizations for different echarts4r features
create_surface <- function() {
  data <- expand.grid(
    x = seq(-3, 3, by = 0.05),
    y = seq(-3, 3, by = 0.05)
  ) |>
    dplyr::mutate(z = sin(x * x + y * y) * x / 3.14)

  data |>
    e_charts(x) |>
    e_surface(y, z, wireframe = list(show = FALSE)) |>
    e_visual_map(z)
}

create_treemap <- function() {
  df <- data.frame(
    parents = c("","earth", "earth", "mars", "mars", "land", "land", "ocean", "ocean", "fish", "fish", "Everything", "Everything", "Everything"),
    labels = c("Everything", "land", "ocean", "valley", "crater", "forest", "river", "kelp", "fish", "shark", "tuna", "venus","earth", "mars"),
    value = c(0, 30, 40, 10, 10, 20, 10, 20, 20, 8, 12, 10, 70, 20)
  )

  # create a tree object
  universe <- data.tree::FromDataFrameNetwork(df)

  universe |>
    e_charts() |>
    e_treemap() |>
    e_title("Treemap")

}

create_sunburst <- function() {

  df <- data.frame(
    parents = c("","earth", "earth", "mars", "mars", "land", "land", "ocean", "ocean", "fish", "fish", "Everything", "Everything", "Everything"),
    labels = c("Everything", "land", "ocean", "valley", "crater", "forest", "river", "kelp", "fish", "shark", "tuna", "venus","earth", "mars"),
    value = c(0, 30, 40, 10, 10, 20, 10, 20, 20, 8, 12, 10, 70, 20)
  )

  # create a tree object
  universe <- data.tree::FromDataFrameNetwork(df)

  # use it in echarts4r
  universe |>
    e_charts() |>
    e_sunburst()
}

create_parallel <- function() {
  # Use mtcars dataset
  mtcars %>%
    e_charts() %>%
    e_parallel(c("mpg", "cyl", "disp", "hp", "wt")) %>%
    e_tooltip() %>%
    e_title("Car Specifications")
}

create_calendar <- function() {
  # Create random daily data
  set.seed(123)
  dates <- seq.Date(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "day")
  values <- runif(length(dates), 10, 100)

  data.frame(date = dates, value = values) %>%
    e_charts(date) %>%
    e_calendar(range = "2023") %>%
    e_heatmap(value, coord_system = "calendar") %>%
    e_visual_map(max = 100) %>%
    e_title("Daily Values")
}

create_gauge <- function() {
  e_charts() %>%
    e_gauge(65.5, "Progress") %>%
    e_title("Project Completion")
}

create_wordcloud <- function() {
  data.frame(
    word = c("Shiny", "R", "Python", "Data", "Stats", "Graph", "ggplot2", "Plotly", "D3.js", "ECharts"),
    freq = c(100, 80, 75, 70, 60, 50, 120, 140, 80, 99)
  ) %>%
    e_charts() %>%
    e_cloud(word, freq) %>%
    e_title("Programmer Skills")
}

create_funnel <- function() {
  # Updated funnel with correct structure
  funnel <- data.frame(
    stage = c("View", "Click", "Purchase"),
    value = c(80, 30, 20)
  )

  funnel %>%
    e_charts() %>%
    e_funnel(value, stage) %>%
    e_title("Funnel")
}
