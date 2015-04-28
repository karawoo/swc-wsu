# Load packages
library("ggplot2")
library("dplyr")

# Read in data
gapminder <- read.csv("gapminder.csv")

# Plot of life expectancy vs gdpPercap
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point()

p1 <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp))
p2 <- p1 + geom_point()
print(p2)

# Plot with log scale
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  scale_x_log10()

p2 + scale_x_log10()

# Challenge 1
# Make a scatterplot of lifeExp vs gdpPercap with only for the data
# for China.

# one method: create a data frame of the China data only
gm_china <- filter(gapminder, country=="China")
ggplot(gm_china, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  scale_x_log10()

# alternative method: make it part of a chain
p_china <- gapminder %>%
  filter(country == "China") %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) + 
  geom_point(size = 3) 

p_china +
  scale_x_log10()

# For example, we might make our scatterplot for all countries, 
# with data from 1952, and then color the points according to the
# continent.
gm_1952 <- filter(gapminder, year==1952)
ggplot(gm_1952, aes(x=gdpPercap, y=lifeExp)) +
  geom_point() + scale_x_log10() +
  aes(color=continent)

# Other geoms - line instead of points (using gm_china defined above)
ggplot(gm_china, aes(x = gdpPercap, y = lifeExp)) + 
  geom_line()

# Multiple layers (points and lines)
ggplot(gm_china, aes(x = gdpPercap, y = lifeExp)) + 
  geom_line(color = "violetred") +
  geom_point(color = "lightblue", size = 4)

# Can also map aesthetics to individual layers: here the points are
# colored by year
ggplot(gm_china, aes(x = gdpPercap, y = lifeExp)) + 
  geom_line(color = "violetred") +
  geom_point(aes(color = year), size = 4)

# Challenge 2: Make a plot of lifeExp vs gdpPercap for China and India, with 
# lines in black but points colored by country.
india_china <- filter(gapminder, country=="India" | country=="China")
p <- ggplot(india_china, aes(y=lifeExp, x=gdpPercap))
p + geom_line() + geom_point(aes(color=country))

p + geom_line(aes(group=country)) + geom_point(aes(color=country))

p + aes(group=country) + geom_line() + geom_point(aes(color=country))

# Univariate geoms
# Histograms:
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x=lifeExp)) + 
  geom_histogram(binwidth = 2, fill = "lightblue")

# Box plots of life expectancy by country
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x = continent, y = lifeExp)) + 
  geom_boxplot()

# Horizontal box plots
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x = continent, y = lifeExp)) + 
  geom_boxplot() + 
  coord_flip()

# Jittered scatter plot on top of boxplot
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x = continent, y = lifeExp)) + 
  geom_boxplot() + 
  geom_point(position = position_jitter(width = 0.1, height = 0))
  
# Faceting - scatterplots by continent
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  scale_x_log10() +
  facet_grid(~ continent)

# Faceting - scatterplots by continent and year
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  scale_x_log10() +
  facet_grid(continent ~ year)

# Faceting - scatterplots by year using facet_wrap
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  scale_x_log10() +
  facet_wrap(~ year)

# Challenge: Select five countries of interest (e.g., China, India, US, France,
# Nigeria) and plot lifeExp vs gdpPercap across time (with geom_line), faceting
# by country.
gapminder %>%
  filter(country %in% c("Iceland", "Mongolia", "China", "Bolivia", "Canada")) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_line() + 
  scale_x_log10() + 
  facet_wrap(~ country)

# themes
gapminder %>%
  filter(country %in% c("Iceland", "Mongolia", "China", "Bolivia", "Canada")) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_line() + 
  scale_x_log10() + 
  facet_wrap(~ country) + 
  theme_bw()

# package with additional themes
install.packages("ggthemes")
library("ggthemes")
gapminder %>%
  filter(country %in% c("Iceland", "Mongolia", "China", "Bolivia", "Canada")) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_line() + 
  scale_x_log10() + 
  facet_wrap(~ country) + 
  theme_wsj() # wall street journal theme

# save a file
gapminder %>%
  filter(country %in% c("Iceland", "Mongolia", "China", "Bolivia", "Canada")) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_line() + 
  scale_x_log10() + 
  facet_wrap(~ country) + 
  theme_bw() +
  ggsave("5_country_plot.png")

gapminder %>%
  filter(country %in% c("Iceland", "Mongolia", "China", "Bolivia", "Canada")) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_line() + 
  scale_x_log10() + 
  facet_wrap(~ country) + 
  theme_bw() +
  ggsave("5_country_plot.pdf", height = 7, width = 10)



