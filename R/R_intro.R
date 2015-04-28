######################
####  Intro to R  ####
######################

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
ls() ## list objects in environment

## a vector of weights
weights <- c(50, 60, 65, 82)
weights
animals <- c("mouse", "rat", "dog")
animals
## to find help on a function:
?mean

## number of elements
length(weights)
length(animals)

## find class of an object:
class(weights)
class(animals)

## structure
str(weights)
str(animals)

## adding elements to vectors
weights <- c(weights, 90)
weights
weights <- c(30, weights)
weights
## challenge 1:
z <- c(x, y, weights)
z
mean(z)

## Data
getwd()
list.files() ## lists files in dir.
setwd("~/Desktop")
list.files()
setwd("~/Desktop/swc-wsu")

## Load data
gapminder <- read.csv("data/gapminder.csv")
head(gapminder)                         # view first 6 rows

## Information about this object
class(gapminder)
str(gapminder)

################################
####  Subsetting: Brackets  ####
################################

weights[1] ## first element
weights[1:3] ## first through third elements

gapminder[1, 1] ## first row, first column
gapminder[1, 3] ## first row, third column
gapminder[500, 5:6] ## 500th row, 5th & 6th column

## extract a single column:
gapminder$pop
## equivalent to:
gapminder[, 5]
gapminder[, "pop"]

## all data for finland
gapminder[gapminder$country == "Finland", ]

## countries and years where pop<=100000
gapminder[gapminder$pop <= 100000, c("country", "year")]
gapminder[gapminder$pop <= 100000, c(1, 3)]

## which of these are equivalent?
gapminder[50, 4]
gapminder[50, "lifeExp"]
gapminder[4, 50]
gapminder$lifeExp[50]

## countries with life exp. > 80
gapminder[gapminder$lifeExp > 80, "country"]

#################################################
####  Subsetting and summarizing with dplyr  ####
#################################################

## install a package
install.packages("dplyr")

## load the package
library("dplyr")

## select columns country, year, and pop
select(gapminder, country, year, pop)

## filter rows where country == "Finland"
filter(gapminder, country == "Finland")

## filter and select simultaneously: population <= 100,000 and columns country
## and year
gapminder_sml <- gapminder %>%
  filter(pop <= 100000) %>%
  select(country, year)

## gdpPercap >= 35,000 and columns country, year, gdpPercap
gapminder %>%
  filter(gdpPercap >= 35000) %>%
  select(country, year, gdpPercap)

## using mutate to create a new tolumn called totalgdp
gapminder %>%
  mutate(totalgdp = gdpPercap * pop)

## find mean total gdp by continent
gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent) %>%
  summarize(meangdp = mean(totalgdp))

## find mean total gdp by continent and year
gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%
  summarize(meangdp = mean(totalgdp))

## find min and mean total gdp by continent and year
meanmingdp <- gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%
  summarize(meangdp = mean(totalgdp),
            mingdp = min(totalgdp))

## find max life expectancy for each continent
gapminder %>%
  group_by(continent) %>%
  summarize(maxlifeExp = max(lifeExp))

## if you have multiple packages with different `summarize` functions, you can
## specify which package's `summarize` to use
gapminder %>%
  group_by(year) %>%
  dplyr::summarize(mean = mean(lifeExp),
            min = min(lifeExp),
            max = max(lifeExp))

## country, year, and pop data for Iceland before 1982
gapminder %>%
  filter(country == "Iceland", 
         year < 1982) %>%
  select(country, year, pop)

## export data
write.csv(gapminder_sml, "gapminder_sml.csv")
