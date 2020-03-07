# Description: Intro to data manipulation with dplyr

# Import data

gapminder <- read.csv("https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv")

# ctrl + enter : Execute from script

# Summarise data
summary(gapminder)

# load the package 
library(dplyr)
?filter

# 1. filter(): pick observations ----
# logical operators
1 == 1 # equality, gives TRUE
1 == 2 # gives FALSE
1 != 3 # TRUE, != is unequal
13 < 14 # smaller than, TRUE
12 > 12 # bigger than, FALSE
12 >= 0 # greater or equal, TRUE
12 <= 12 # smaller or equal

# only australian data
australia <- filter(gapminder, country == "Australia")
"this" == "that" # FALSE
"this" == "this" # TRUE

# only life expectancy higher than 81
life80 <- filter(gapminder, lifeExp > 81)

# 2. arrange(): reorder rows ----
# highest GDP per capita
arrange(gapminder, gdpPercap)
head(arrange(gapminder, desc(gdpPercap)))

# 3. select(): pick variables ----
# select can be used to reorder the groups
gap_small <- select(gapminder, year, country, gdpPercap)

# combine operations 
gap_small_97 <- filter(gap_small, year == 1997)

# same thing as nesting 
gap_small_97 <-filter(select(gapminder, year, country, gdpPercap), year == 1997)

# same thing, but with the pipe operator '%>%'
# can pipe from left side to right side of function
gap_small_97 <- gapminder %>%   #selecting data from gapminder
  select(year, country, gdpPercap) %>% # selecting the groups from the dataset
  filter(year == 1997) #filtering to 1997

# All three cases above for gap_small_97 gets the same data, different way, same output

gapminder %>%
  summary()
# Exactly the same as
summary(gapminder)

# challenge: 2002 life expectancy observation for Eritrea
# Attempt 1
gap_lifeExp_Eri <- gapminder %>%
  select(year, country, lifeExp) %>%
  filter(country == "Eritrea" & year == 2002)

# Solution 
eritrea_2002 <- gapminder %>%
  select(year, country, lifeExp) %>%
  filter(country == "Eritrea", year == "2002")

# 4. mutate(): create new variables ----

# pipe operator: ctrl + shift + M
gap_gdp <- gapminder %>% 
  mutate(gdp = gdpPercap * pop,
         gpdMil = gdp / 10^6)

# 5. summarise(): collapse to a single summary ----
gapminder %>% 
  summarise(meanLE = mean(lifeExp))

# 6. group_by(): change the scope ----
# change the scope of our operation

gapminder %>% 
  group_by(continent)

# mean life expectancy for each continent in 2007 
gapminder %>% 
  filter(year == 2007) %>% 
  group_by(continent) %>% 
  summarise(meanLE = mean(lifeExp))

# challenge: max life expectancy ever recorded for each country 
# Attempt 2
maxLE2 <- gapminder %>% 
  group_by(country) %>%
  summarise(maxLE2 = max(lifeExp))

# Solution 
maxLE <- gapminder %>% 
  group_by(country) %>% 
  summarise(maxLE = max(lifeExp)) %>% 
  arrange(maxLE)
maxLE # prints the tibble

# using starwars data
?starwars
starwars %>% 
  group_by(species) %>% 
  summarise(n = n(),  # n variable contains n amount of rows in group
            mass = mean(mass, na.rm = TRUE)) %>% 
  filter(n>1)

# associating dlpyr with ggplot2
library(ggplot2)
gapminder %>% 
  filter(continent == "Europe") %>% 
  group_by(year) %>% 
  summarise(sum = sum(pop)) %>% 
  ggplot(aes(x= year, 
             y = sum)) +
  geom_line()

# top and bottom variations in life expectancy 
gapminder %>% 
  group_by(country) %>% 
  summarise(maxLifeExp = max(lifeExp),
            minLifeExp = min(lifeExp)) %>% 
  mutate(dif = maxLifeExp - minLifeExp) %>% 
  arrange(desc(dif)) %>% 
  slice(1:10, (nrow(.)-10):nrow(.)) %>% 
  ggplot(aes(x = reorder(country, dif),
             y = dif)) +
  geom_col() + 
  coord_flip()


file.create("scripts/Rstudiodplyr.R")
