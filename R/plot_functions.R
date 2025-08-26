library(shiny)
library(ggplot2)
library(bslib)
library(dplyr)
# Extension packages
library(ggbeeswarm)
library(ggbump)
library(ggalluvial)
library(ggridges)
library(ggcorrplot)
library(ggmosaic)
library(ggradar)
library(ggwordcloud)

#ggplot###########

# Define plot functions
create_scatter <- function() {
  ggplot(palmerpenguins::penguins, aes(bill_length_mm, body_mass_g)) +
    geom_point(aes(color = factor(species)), size = 3) +
    geom_smooth(method = "lm", se = TRUE, color = "black") +
    labs(title = "Bill Length vs Body Mass",
         x = "Bill Length (mm)",
         y = "Body Mass (g)",
         color = "Species") +
    ggplot2::scale_color_viridis_d(option = "C")+
    theme_minimal(base_size = 18)
}

#create_scatter()

create_boxplot <- function() {
  ggplot(diamonds, aes(cut, price)) +
    geom_boxplot(aes(fill = cut)) +
    labs(title = "Diamond Prices by Cut Quality",
         x = "Cut", y = "Price (USD)") +
    theme_minimal(base_size = 18)
}

create_density <- function() {
  ggplot(faithful, aes(waiting)) +
    geom_density(aes(fill = "density"), alpha = 0.7) +
    labs(title = "Old Faithful Eruption Waiting Times",
         x = "Waiting Time (minutes)", y = "Density") +
    theme_minimal(base_size = 18) +
    theme(legend.position = "none")
}

create_facet <- function() {
  economics_long |>
    dplyr::filter(variable == "unemploy") |>
    ggplot(aes(date, value)) +
    geom_line() +
    labs(title = "US Unemployment Rate",
         x = "Date", y = "Rate") +
    theme_minimal(base_size = 18)
}

create_bar <- function() {
  ggplot(mpg, aes(class)) +
    geom_bar(aes(fill = as.factor(cyl))) +
    labs(title = "Car Class by Cylinders",
         x = "Vehicle Class", y = "Count") +
    coord_flip() +
    #color
    scale_fill_brewer(palette = "Blues") +
    labs(fill = "Cylinders") +
    theme_minimal(base_size = 18)
}

create_violin <- function() {
  ggplot(diamonds, aes(cut, price)) +
    geom_violin(aes(fill = cut)) +
    labs(title = "Diamond Price Distribution by Cut",
         x = "Cut", y = "Price") +
    theme_minimal(base_size = 18)
}

create_heatmap <- function() {
  diamonds %>%
    count(cut, color) %>%
    ggplot(aes(cut, color)) +
    geom_tile(aes(fill = n)) +
    scale_fill_viridis_c() +
    labs(title = "Diamond Count by Cut and Color",
         x = "Cut", y = "Color") +
    theme_minimal(base_size = 18)
}

create_area <- function() {
  economics %>%
    ggplot(aes(date, unemploy)) +
    geom_area(fill = "steelblue", alpha = 0.5) +
    labs(title = "US Unemployment Over Time",
         x = "Date", y = "Unemployment") +
    theme_minimal(base_size = 18)
}

create_bubble <- function() {
  ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(size = cty, color = class), alpha = 0.6) +
    labs(title = "Engine Size vs. Highway MPG",
         x = "Engine Displacement", y = "Highway MPG") +
    theme_minimal(base_size = 18)
}

create_errorbar <- function() {
  diamonds %>%
    group_by(cut) %>%
    summarise(
      mean_price = mean(price),
      se = sd(price)/sqrt(n())
    ) %>%
    ggplot(aes(cut, mean_price)) +
    geom_point(size = 3) +
    geom_errorbar(aes(ymin = mean_price - se, ymax = mean_price + se), width = 0.2) +
    labs(title = "Mean Diamond Price by Cut (with SE)",
         x = "Cut", y = "Mean Price") +
    theme_minimal(base_size = 18)
}


## extensions #########
# Create example plots for each extension
create_beeswarm <- function() {
  ggplot(iris, aes(Species, Sepal.Length)) +
    geom_beeswarm(aes(color = Species)) +
    labs(title = "Iris Sepal Length Distribution",
         subtitle = "Using ggbeeswarm") +
    theme_minimal(base_size = 18)
}

create_bump <- function() {
  data <- data.frame(
    year = rep(2015:2019, 5),
    rank = c(1,1,2,3,1, 2,2,1,1,2, 3,3,3,2,3, 4,4,4,4,4, 5,5,5,5,5),
    name = rep(c("A","B","C","D","E"), each=5)
  )
  ggplot(data, aes(year, rank, color = name)) +
    geom_bump() +
    labs(title = "Rank Changes Over Time",
         subtitle = "Using ggbump") +
    theme_minimal(base_size = 18)
}

create_alluvial <- function() {
  data <- data.frame(
    x = rep(c("Group A", "Group B"), each = 100),
    y = rep(c("Type 1", "Type 2"), times = 100),
    freq = sample(1:10, 200, replace = TRUE)
  )
  ggplot(data,
         aes(axis1 = x, axis2 = y, y = freq)) +
    geom_alluvium() +
    geom_stratum() +
    labs(title = "Flow Diagram",
         subtitle = "Using ggalluvial") +
    theme_minimal(base_size = 18)
}

create_ridges <- function() {
  ggplot(iris, aes(x = Sepal.Length, y = Species)) +
    geom_density_ridges(aes(fill = Species)) +
    labs(title = "Sepal Length Distribution by Species",
         subtitle = "Using ggridges") +
    theme_minimal(base_size = 18)
}

create_corrplot <- function() {
  corr <- cor(iris[, 1:4])
  ggcorrplot(corr,
             hc.order = TRUE,
             type = "lower",
             lab = TRUE) +
    labs(title = "Correlation Matrix of Iris Features",
         subtitle = "Using ggcorrplot") +
    theme(text = element_text(size = 18))
}

create_mosaic <- function() {
  titanic_df <- as.data.frame(Titanic)

  ggplot(data = titanic_df) +
    geom_mosaic(aes(weight = Freq, x = product(Survived, Sex), fill = Class)) +
    labs(title = "Titanic Survival by Sex and Class",
         subtitle = "Using ggmosaic") +
    theme_minimal(base_size = 18) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

create_radar <- function() {
  data <- data.frame(
    metric = c("Speed", "Power", "Agility", "Intelligence", "Strength"),
    character1 = c(90, 80, 70, 60, 85),
    character2 = c(70, 85, 90, 75, 65)
  )
  ggradar(data,
          values.radar = c(0, 50, 100),
          grid.min = 0, grid.mid = 50, grid.max = 100) +
    labs(title = "Character Attributes Comparison",
         subtitle = "Using ggradar")
}

create_wordcloud <- function() {
  words <- data.frame(
    word = c("R", "Shiny", "ggplot2", "Data", "Visualization", "Analysis",
             "Statistics", "Programming", "Science", "Graphics"),
    freq = sample(10:50, 10)
  )
  ggplot(words, aes(label = word, size = freq)) +
    geom_text_wordcloud() +
    scale_size_area(max_size = 20) +
    labs(title = "Word Cloud",
         subtitle = "Using ggwordcloud") +
    theme_minimal(base_size = 18)
}
