## Commands entered as part of the R Intro

2 + 2
5 * 6
10 / 4
x <- 8
x * 3
y <- x / 2
y
x
x <- 15
x
y
ls() # list objects in environment

# a vector of weights
weights <- c(50, 60, 65, 82)
weights
animals <- c("mouse", "rat", "dog")
animals
# to find help on a function:
?mean

# number of elements
length(weights)
length(animals)

# find class of an object:
class(weights)
class(animals)

# structure
str(weights)
str(animals)

# adding elements to vectors
weights <- c(weights, 90)
weights
weights <- c(30, weights)
weights
# challenge 1:
z <- c(x, y, weights)
z
mean(z)

# Data
getwd()
list.files() # lists files in dir.
setwd("~/Desktop")
list.files()
setwd("~/Desktop/swc-wsu")

gapminder <- read.csv("data/gapminder.csv")
head(gapminder)

class(gapminder)
str(gapminder)

weights[1]
weights[1:3]

# first row, first column
gapminder[1, 1]
# first row, third column
gapminder[1, 3]
# 500th row, 5th & 6th column
gapminder[500, 5:6]

gapminder$pop
# equivalent to:
gapminder[, 5]
gapminder[, "pop"]

# all data for finland
gapminder[gapminder$country == "Finland", ]

# countries and years where pop<=100000
gapminder[gapminder$pop <= 100000, c("country", "year")]
gapminder[gapminder$pop <= 100000, c(1, 3)]

gapminder[50, 4]
gapminder[50, "lifeExp"]
gapminder[4, 50]
gapminder$lifeExp[50]

# countries with life exp. > 80
gapminder[gapminder$lifeExp > 80, "country"]

# install a package
install.packages("dplyr")
library("dplyr")

select(gapminder, country, year, pop)
filter(gapminder, country == "Finland")

gapminder_sml <- gapminder %>%
  filter(pop <= 100000) %>%
  select(country, year)

gapminder %>%
  filter(gdpPercap >= 35000) %>%
  select(country, year, gdpPercap)

gapminder %>%
  mutate(totalgdp = gdpPercap * pop)

gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent) %>%
  summarize(meangdp = mean(totalgdp))

gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%
  summarize(meangdp = mean(totalgdp))

meanmingdp <- gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%
  summarize(meangdp = mean(totalgdp),
            mingdp = min(totalgdp))

gapminder %>%
  group_by(continent) %>%
  summarize(maxlifeExp = max(lifeExp))

gapminder %>%
  group_by(year) %>%
  dplyr::summarize(mean = mean(lifeExp),
            min = min(lifeExp),
            max = max(lifeExp))

gapminder %>%
  filter(country == "Iceland", 
         year < 1982) %>%
  select(country, year, pop)

write.csv(gapminder_sml, "gapminder_sml.csv")