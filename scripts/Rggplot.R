# Description: intro to ggplot2 visualisations

# Load the package
library(ggplot2)
# Execute from script: ctrl + enter

# 3 essential elements 
# shortcut function: qplot() ----
qplot(data = msleep, # where the data comes from
      x = conservation, # mapping of the aesthetics to variables
      geom = "bar") # geometrical elements to represent data

# data, mapping, geom

# scatterplot ----
# data: economics 
# full ggplot2 syntax

ggplot(data = economics,
       mapping = aes(x = date, 
                     y =unemploy)) + #plus sign specifies to R that line is single command
  geom_point() # can contain all mapping of aesthetics
# type geom_ and it will list all available map types

# data: mpg "miles per gallon" ----
# is a bigger engine more fuel efficient?
ggplot(data = mpg, 
       mapping = aes(x = displ, # engine displacement, in litres
                     y = hwy, # highway miles per gallon
                     colour = class)) + # "type" of car
  geom_point()

# trendlines + layering ----
ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy)) +
  geom_point(mapping = aes(colour = class)) + # adding points to the trend line
  geom_smooth(method = "lm") # lm = linear model

#if you put colour in the ggplot instead of specific geom, this will apply to all mapping instead
ggplot(data = mpg,
       mapping = aes(x = displ,
                     y = hwy,
                     colour = class)) +
  geom_point() + # adding points to the trend line
  geom_smooth(method = "lm") # lm = linear model


# economics again! ----
ggplot(data = economics, 
       mapping = aes(x = date,
                     y = unemploy)) + 
  geom_point(mapping = aes(colour = uempmed)) +
  geom_smooth()

# bar charts with diamonds data ----
?diamonds
# you can start to omit the arguments name
ggplot(diamonds,
       aes(x = cut,
           fill = clarity)) + # colour = clarity will only colour the outline, fill colours whole
  geom_bar()

# theming + labelling + coordinates ----
ggplot(diamonds,
       aes(x= cut)) + 
  geom_bar(fill = "tomato") + 
  labs(title = "Where are the bad ones?", # title for x, y axis
       x = "Quality of the cut",
       y = "Number of diamonds") +
  coord_flip() + # flips the x,y axis, handy for long labels
  theme_minimal() # theme_ gives you the themes of graphs

# save with a command ----
ggsave(filename = "horiz_bar_screen.png",
       dpi = "screen") # dpi = screen resolution especially for png

