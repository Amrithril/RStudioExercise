# Description: Intro to heatmaps in R
# Author: Pritii Tam
# 2020-03-06

# 1. Base function: heatmap() ----
?mtcars
# ctrl + enter: execute from script

heatmap(mtcars)
?heatmap
class(mtcars) #matrices is suitable, but not dataframe 

# Convert from df to matrix
mtcars_mat <- data.matrix(mtcars)
mtcars_norm <- mtcars

heatmap(mtcars_mat)

# Changing scale argument from row to column
heatmap(mtcars_mat,
        scale = "column",
        col = cm.colors(n = 15))
# ylorrd is often used

hcl.pals() # list colour palettes available

# remove dendogram
heatmap(mtcars_mat,
        scale = "column",
        Colv = NA,
        Rowv = NA,
        col = cm.colors(n = 10))

# To check for the dendogram issue,use  colnames(mtcars_mat)

# Cleanup the environment
rm(list = ls())

# 2. gplots::heatmap.2() ----
# install.packages("gplots")
library(gplots)
?heatmap.2

# import protein data from the web
rawdata <- read.csv("https://raw.githubusercontent.com/ab604/heatmap/master/leanne_testdata.csv")

# Data manipulation to cleanup datafram to remove unwanted variables and headers
rawdata <- rawdata[,2:7] # indexing to select only columns 2 to 7
colnames(rawdata) <- c(paste("Control", 1:3, sep = "_"),
                       paste ("Treatment", 1:3, sep = "_"))
# the manipulation above guarantees we've got the right order

# convert to matrix
data_mat <- data.matrix(rawdata)

# create a heatmap.2
# heatmap.2 does clustering before scaling step
heatmap.2(data_mat,
          scale = "row")

# Need more data manipulation for scaling before clustering
# Scale data before visualising
?scale
?t
data_scaled <- t(scale(t(data_mat)))
# reset the graphics device by dev.off() in console
# magic word: dev.off() to kill n restart the graphic device
dev.off()
heatmap.2(data_scaled)

# more control over colours
my_palette <- colorRampPalette(c("blue",
                                 "white",
                                 "red"))
heatmap.2(data_scaled,
          col = my_palette(n = 20),
          trace = "none",
          dendrogram = "row", # instead of Colv = NA, you can use this
          main = "A good title",
          margins =c(6,4),
          cexRow = 0.40,
          cexCol = 0.80)
                 
# cleanup the environment
rm(list = ls())

# 3.pheatmap::pheatmap() ----
# install.packages("pheatmap")
library(pheatmap)
?pheatmap

# generate random data
d <- matrix(rnorm(25), 5, 5)
colnames(d) <- paste0("Treatment", 1:5)
rownames(d) <- paste0("Gene", 1:5)

# pheatmap visualisation
pheatmap(d,
         main = "Pretty heatmap",
         cellwidth = 50,
         cellheight = 30,
         fontsize = 12,
         display_numbers = TRUE,
         scale = "row",
         filename = 'pheatmap.pdf')

# cleanup the environment
rm(list = ls())

## Summarise key differences between the three functions
# stats::heatmap(): scale(row) -> cluster -> colour
# gplots::heatmap.2(): cluster -> scale(none) -> colour, extra step to scale data first before clustering
# pheatmap::pheatmap(): scale(none) -> cluster -> colour

# 4. A dataframe in ggplot2 ----
# install.packages("ggplot2")
library(ggplot2)
?esoph

# subset the data to age group 55-64
esoph_sub <- subset(esoph, agegp == "55-64")

# visualise frequency of cancer
ggplot(esoph_sub, 
       aes(x = alcgp,
           y = tobgp,
           fill = ncases / (ncases + ncontrols))) +
  geom_tile(colour = "white") + 
  scale_fill_gradient(low = "white",
                      high = "steelblue") + 
  theme_minimal() +
  labs(fill = "Cancer frequency",
       x = "Alcohol consumption",
       y = "Tobacco consumption")

# cleanup the environment
rm(list = ls())


library(filesstrings)
file.move("C:/Users/GNR/Desktop/RStudio/RstudioExercise/Rheatmaps2.png", "C:/Users/GNR/Desktop/RStudio/RstudioExercise/plots")
