widget_code <- list(
  plotly = 'plot_ly(iris,\n  x = ~Sepal.Length,\n  y = ~Sepal.Width,\n  z = ~Petal.Length,\n  color = ~Species,\n  type = "scatter3d",\n  mode = "markers") %>%\n  layout(title = "3D Scatter Plot of Iris Dataset")',

  network = 'nodes <- data.frame(\n  id = 1:6,\n  label = paste("Node", 1:6),\n  group = rep(c("A", "B"), each = 3)\n)\n\nedges <- data.frame(\n  from = c(1,1,2,2,3,4),\n  to = c(2,3,4,5,6,6)\n)\n\nvisNetwork(nodes, edges) %>%\n  visGroups(groupname = "A", color = "lightblue") %>%\n  visGroups(groupname = "B", color = "lightgreen") %>%\n  visOptions(highlightNearest = TRUE)',

  datatable = 'datatable(iris[1:30,],\n  options = list(pageLength = 10),\n  rownames = FALSE) %>%\n  formatRound(columns = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),\n            digits = 1)',

  highchart = 'stocks <- data.frame(\n  date = seq(as.Date("2023-01-01"), by = "day", length.out = 100),\n  value = cumsum(rnorm(100, 0, 1))\n)\n\nhighchart() %>%\n  hc_title(text = "Interactive Time Series") %>%\n  hc_xAxis(type = "datetime") %>%\n  hc_add_series(data = stocks,\n              hcaes(x = date, y = value),\n              type = "line",\n              name = "Stock Price")',

  sankey = 'nodes <- data.frame(name = c("A", "B", "C", "D", "E"))\nlinks <- data.frame(\n  source = c(0, 0, 1, 2, 3),\n  target = c(1, 2, 3, 4, 4),\n  value = c(10, 20, 15, 25, 30)\n)\n\nsankeyNetwork(Links = links, Nodes = nodes,\n            Source = "source", Target = "target",\n            Value = "value", NodeID = "name",\n            fontSize = 16, nodeWidth = 30)',

  heatmap = 'cor_matrix <- cor(mtcars)\nd3heatmap(cor_matrix,\n          colors = "RdYlBu",\n          dendrogram = "both",\n          show_grid = TRUE)'
)
