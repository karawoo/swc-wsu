## convert Fahrenheit to Celsius
f2c <- function(fahr) {
  return((fahr - 32) * 5/9)
}

## plotting function
gapminder <- read.csv("../data/gapminder.csv")

plot_year <- function(year=2007, data=gapminder)
{
    library(dplyr)
    library(ggplot2)

    the_year <- year
    gm_year <- filter(data, year==the_year)

    ggplot(gm_year, aes(y=lifeExp, x=gdpPercap)) +
        geom_point() + scale_x_log10()
}

## try this out
plot_year(year = 1952)
plot_year(year = 2002)

## function to plot lifeExp vs gdpPercap across years for a selected country
plot_lifeexp <- function(country, data = gapminder) {
  library("dplyr")
  library("ggplot2")
  cc <- country
  data %>%
    filter(country == cc) %>%
    ggplot(aes(y = lifeExp, x = gdpPercap)) +
    geom_point()
}

plot_lifeexp("Iceland")
