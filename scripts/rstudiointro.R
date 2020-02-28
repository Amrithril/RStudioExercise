# Description: Intro to R and RStudio 
# Author: Pritii Tam
# Date: 2020-02-21


# rm() removes items
# rm(list = ls()) removes everything from environment
# dir.create("name"), creates a folder in directory
# file.create("scripts/cmds.R"), puts a R. file into scripts directory, will reply with TRUE
# file.edit("scripts/cmds.R"), opens the R. file. script is a text file to help coding
# This is a script

dir.create("data")
dir.create("scripts")
file.create("scripts/rstudiointro.R")
obj1 <- log10(567)
rm(obj1)
# Import some data
# Download file from the internet
download.file(url = "https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv", destfile = "data/gapminderdata.csv")

# Import tabular data as a data frame
gapminder <- read.csv("data/gapminderdata.csv")

# Explore the data
str(gapminder) # quick look at class, sample of data, variable names
summary(gapminder) # summary statistics
head(gapminder) # print the 6 first lines
View(gapminder) # spreadsheet-like views


# find the max life expectancy in dataset
max(gapminder$lifeExp)

# extend R with other packages
# install.packages("praise") (but only do this in console, to safeguard the script)
# first load the package
library(praise)
praise()

# ggplot2: data visualisation
# install.packages("ggplot2") but we already have tidyverse
library(ggplot2)
qplot(data=gapminder, 
      x=gdpPercap, 
      y = lifeExp,
      colour = continent,
      geom = "point")
#Ctrl + S to save, the asterisk shows its not saved yet
#Do NOT SAVE the workspace image when quitting, because it will alter the data!

