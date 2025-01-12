# Create example visualizations for different HTML widgets
create_plotly_3d <- function() {
  # Create 3D scatter plot
  plot_ly(iris,
          x = ~Sepal.Length,
          y = ~Sepal.Width,
          z = ~Petal.Length,
          color = ~Species,
          type = "scatter3d",
          mode = "markers") %>%
    layout(title = "3D Scatter Plot of Iris Dataset")
}

create_network <- function() {
  # Create nodes
  nodes <- data.frame(
    id = 1:6,
    label = paste("Node", 1:6),
    group = rep(c("A", "B"), each = 3)
  )

  # Create edges
  edges <- data.frame(
    from = c(1,1,2,2,3,4),
    to = c(2,3,4,5,6,6)
  )

  visNetwork(nodes, edges) %>%
    visGroups(groupname = "A", color = "lightblue") %>%
    visGroups(groupname = "B", color = "lightgreen") %>%
    visOptions(highlightNearest = TRUE)
}

create_datatable <- function() {
  datatable(iris[1:30,],
            options = list(pageLength = 10),
            rownames = FALSE) %>%
    formatRound(columns = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"), digits = 1)
}

create_highchart <- function() {
  stocks <- data.frame(
    date = seq(as.Date("2023-01-01"), by = "day", length.out = 100),
    value = cumsum(rnorm(100, 0, 1))
  )

  highchart() %>%
    hc_title(text = "Interactive Time Series") %>%
    hc_xAxis(type = "datetime") %>%
    hc_add_series(data = stocks,
                  hcaes(x = date, y = value),
                  type = "line",
                  name = "Stock Price")
}

create_sankey <- function() {
  # Sample data for Sankey diagram
  nodes <- data.frame(name = c("A", "B", "C", "D", "E"))
  links <- data.frame(
    source = c(0, 0, 1, 2, 3),
    target = c(1, 2, 3, 4, 4),
    value = c(10, 20, 15, 25, 30)
  )

  sankeyNetwork(Links = links, Nodes = nodes,
                Source = "source", Target = "target",
                Value = "value", NodeID = "name",
                fontSize = 16, nodeWidth = 30)
}

create_d3heatmap <- function() {
  # Create sample correlation matrix
  cor_matrix <- cor(mtcars)
  d3heatmap(cor_matrix,
            colors = "RdYlBu",
            dendrogram = "both",
            show_grid = TRUE)
}
