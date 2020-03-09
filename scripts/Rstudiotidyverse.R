# Description: Next steps in the Tidyverse with tidyr and purrr
# Date: 2020-03-09

# Load tidyverse
library(tidyverse)

# import some data from The World Bank
# Climate dataset from 2011 (messy data)
# NA Value or missing value coded as .. in this dataset
climate_raw <- read_csv("https://gitlab.com/stragu/DSH/raw/master/R/tidyverse_next_steps/data_wb_climate.csv",
                        na = "..")

# Use tidyr to lengthen the data
# Years will be converted from character to integer
climate_long <- pivot_longer(climate_raw,
                             '1990' : '2011',
                             names_to = "year",
                             values_to = "value")  %>% 
  mutate(year = as.integer(year))

# Use tidyr to widen the data
# Square bracket is indexing in R, and asking to find Series code and name matches
# 1. Store the codebook
codes <- unique(climate_long[,c("Series code", "Series name")])

# 2. Widen data
# Select function reorders variables
climate_tidy <- climate_long %>%
  select(- 'Series name', -SCALE, -Decimals) %>% 
  pivot_wider(names_from = 'Series code',
              values_from = value)

# remove useless country groups
groups <- c("Europe & Central Asia",
            "East Asia & Pacific",
            "Euro area",
            "High income",
            "Lower middle income",
            "Low income",
            "Low & middle income",
            "Middle income",
            "Middle East & North Africa",
            "Latin America & Caribbean",
            "South Asia",
            "Small island developing states",
            "Sub-Saharan Africa",
            "Upper middle income",
            "World")
climate_tidy <- climate_tidy %>%
  dplyr::filter(!'Country name' %in% groups)

groups <- c("Europe & Central Asia",
            "East Asia & Pacific",
            "Euro area",
            "High income",
            "Lower middle income",
            "Low income",
            "Low & middle income",
            "Middle income",
            "Middle East & North Africa",
            "Latin America & Caribbean",
            "South Asia",
            "Small island developing states",
            "Sub-Saharan Africa",
            "Upper middle income",
            "World")
climate_tidy <- climate_tidy %>% 
  filter(!`Country name` %in% groups)
# USE GRAVE ACCENT FOR COUNTRY NAME HERE! ``, LOCATED NEXT TO "1" numerical 

# To check if dataset has single countries left
unique(climate_tidy$`Country name`)

# Visualise with ggplot2
climate_tidy %>% 
  ggplot(aes(x = year,
             y = EN.ATM.CO2E.KT,
             group = `Country name`)) +
  geom_line()

# Visualise global emissions 
climate_tidy %>% 
  group_by(year) %>% 
  summarise(CO2 = sum(EN.ATM.CO2E.KT, na.rm = TRUE)) %>% 
  ggplot(aes(x = year, 
             y = CO2)) + 
  geom_point()

# remove years without data (i.e. 2009, 2010 and 2011)
climate_tidy %>% 
  group_by(year) %>% 
  summarise(CO2 = sum(EN.ATM.CO2E.KT, na.rm = TRUE)) %>%
  filter(year < 2009) %>% 
  ggplot(aes(x = year, 
             y = CO2)) + 
  geom_point()

## Using purrr for iterating with functional programming
mtcars
# to check if matrix or dataframe
class(mtcars)
?mtcars # all numerical, handy to apply operation in each column
 
library(stats)
# build a proper loop in R
output <- vector("double", ncol(mtcars))
# For sequence along the variables of mtcars, we are repeating operation everytime we found one
for (i in seq_along(mtcars)) {
  output[[i]] <- median(mtcars[[i]])
}
output

# Specific function in purrr from the map family
car_medians <- map_dbl(mtcars, median)
car_medians
# Easier to type than the whole loop, less things from getting wrong, and keeps the variable names to understand the output
typeof(car_medians)

# different data type as output