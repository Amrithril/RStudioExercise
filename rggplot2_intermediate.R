# Description: intermediate session on ggplot2
# Author: Pritii Tam
# 2020 - 03 - 04
 
# Import data
gapminder <- read.csv("https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv")

# ctrl + enter: execute from script

# familiarise yourself with the data
summary(gapminder)
View(gapminder)
dir.create("plots")


# load the package 
library(ggplot2)

# population growth
ggplot(data = gapminder,
       mapping = aes(x = year,
                     y = pop,
                     colour = continent)) +
  labs(title = "Continent v Year", # title for x, y axis
       x = "Year",
       y = "Population") + 
    geom_point() +
  scale_colour_brewer(palette = "Dark2")

# more control over colour
?scale_colour_brewer #type of palettes to express ggplot data

# visualise Colour Brewer palettes
library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)

# Save some typing 
p <- ggplot(data = gapminder, 
            mapping = aes(x = year,
                          y = pop,
                          colour = continent)) +
  geom_point()

# custom palette----
p + 
  scale_colour_manual(values = c("blue", "red", "purple", "green", "orange"))

# if want to replace with manually picked colours
p + 
  scale_colour_manual(values = c("#72CCBA", "#F0E98B", "#E8A5E2", "#F56767", "#FFB45E"))

# find out about R colour names----
colours()

# more comfortable to use the add-in colourpicker

# modify y scake to spread data
p +
  scale_y_log10()

# modify our x axis breaks ----
# create a list of years
unique_years <- unique(gapminder$year) #finds unique year values in gapminder data

# use the vector for breaks ----
p +
  scale_x_continuous(breaks = unique_years) + #modifies the x axis breaks to actual values
# simplify breaks on y axis
  scale_y_continuous(breaks = c(0, 100000000, 200000000, 500000000, 1000000000),
                     labels = c(0, "100 m", "200 m", "500 m", "1 b"))

# modify the y scale range ----
# to zoom closer to graph by y -axis change
p +
  ylim(c(0, 360000000))

# histograms ----
# modify positions also can be done here, position argument
ggplot(gapminder,
       aes(x = lifeExp,
           fill = continent)) + 
  geom_histogram(bins = 10, # bins is the no. of squares
                position = "dodge" ) 
# "stack" if you want a histogram and differences,
# "fill" fills up the whole area
# "dodge" divides data

# faceting & theming ----
# divides histogram to several panels

#use ggthemes for more options
#library(ggthemes)
ggplot(gapminder, 
       aes(x = lifeExp, 
           fill = continent)) + 
  geom_histogram(bins = 40) +
  facet_wrap(~continent) + 
  theme(legend.position = "none") + # change the legend position 
  theme_minimal() +
  theme(legend.position = "none") + # the legend appears again because defaults reset
  xlab("Life Expectancy") +
  ylab("Count")

# Customising a scatterplot ----
ggplot(gapminder, 
       aes(x = gdpPercap,
           y = lifeExp)) +
  geom_point(aes(colour = continent),
             alpha = 0.5) +# alpha is transparency
  geom_smooth(method = "lm") + # method is linear model regression, we dont put this in aes because it is a overall population lm 
  scale_x_log10() +
  labs(x = "GDP per capita",
       y = "Life Expectancy",
       title = "How does GDP relate to life expectancy?") +
  theme_bw()

# save a plot with command
ggsave("plots/GDPLifeExp.png", width = 20, height = 15, units = "cm")

# more geoms
ggplot(gapminder, aes(x= continent)) +
  geom_bar()

ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_boxplot()

ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_violin() +
  theme(axis.text.x = element_text(angle = 90))

# Use esquisse to cheat
library(ggplot2)

ggplot(gapminder) +
 aes(x = continent, y = gdpPercap) +
 geom_boxplot(fill = "#0c4c8a") +
 theme_minimal()

ggplot(gapminder) +
 aes(x = continent, y = gdpPercap, fill = continent) +
 geom_violin(adjust = 1L, scale = "area") +
 scale_fill_hue() +
 theme_minimal()
