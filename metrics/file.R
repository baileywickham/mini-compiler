library(tikzDevice) # load the tikzDevice package
library(ggplot2) # load the ggplot2 package
data(mtcars) # load the dataset

# Create the plot
p <- ggplot(data = mtcars, aes(x = cyl, y = mpg)) +
  geom_bar(stat = "identity")

# Create the tex file with tikzDevice
tikz(file = 'p_tex.tex', width = 4.5, height = 4.5)
p
dev.off()

