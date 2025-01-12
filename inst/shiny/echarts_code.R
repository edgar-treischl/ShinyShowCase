echarts_code <- list(
  surface = 'x <- seq(-5, 5, length.out = 50)\ny <- seq(-5, 5, length.out = 50)\ngrid <- expand.grid(x = x, y = y)\ngrid$z <- with(grid, sin(sqrt(x^2 + y^2))/sqrt(x^2 + y^2))\n\ngrid %>%\n  e_charts() %>%\n  e_surface(x, y, z) %>%\n  e_visual_map(z) %>%\n  e_theme("dark")',

  treemap = 'data <- data.frame(\n  parent = c(NA, "Total", "Total", "A", "A", "B", "B"),\n  name = c("Total", "A", "B", "A1", "A2", "B1", "B2"),\n  value = c(NA, NA, NA, 25, 15, 30, 20)\n)\n\ndata %>%\n  e_charts() %>%\n  e_treemap(parent, name, value) %>%\n  e_title("Sales Distribution")',

  sunburst = 'data <- data.frame(\n  parent = c(NA, "Root", "Root", "Branch A", "Branch A", "Branch B"),\n  name = c("Root", "Branch A", "Branch B", "Leaf 1", "Leaf 2", "Leaf 3"),\n  value = c(NA, NA, NA, 15, 25, 30)\n)\n\ndata %>%\n  e_charts() %>%\n  e_sunburst(parent, name, value) %>%\n  e_title("Organization Structure")',

  parallel = 'iris %>%\n  group_by(Species) %>%\n  e_charts() %>%\n  e_parallel(c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")) %>%\n  e_tooltip()',

  calendar = 'dates <- seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "day")\ndata <- data.frame(\n  date = dates,\n  value = abs(sin(1:365/52)*100)\n)\n\ndata %>%\n  e_charts(date) %>%\n  e_calendar(range = "2023") %>%\n  e_heatmap(value, coord_system = "calendar") %>%\n  e_visual_map(max = 100)',

  gauge = 'e_charts() %>%\n  e_gauge(78.9, "Performance") %>%\n  e_title("System Performance")',

  wordcloud = 'words <- data.frame(\n  word = c("Data", "Visualization", "Analytics", "Machine Learning", \n           "Statistics", "Programming", "Algorithm", "Model"),\n  freq = c(100, 85, 70, 65, 60, 55, 50, 45)\n)\n\nwords %>%\n  e_charts() %>%\n  e_cloud(word, freq) %>%\n  e_title("Data Science Terms")',

  funnel = 'stages <- data.frame(\n  stage = c("Visits", "Downloads", "Sign-ups", "Purchases"),\n  value = c(1000, 750, 500, 250)\n)\n\nstages %>%\n  e_charts() %>%\n  e_funnel(stage, value) %>%\n  e_title("Conversion Funnel")'
)
