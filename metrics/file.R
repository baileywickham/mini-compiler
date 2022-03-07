library(tikzDevice) # load the tikzDevice package
library(ggplot2) # load the ggplot2 package
library(RColorBrewer)

#data(mtcars) # load the dataset

setwd('C:/Users/alexm/Documents/431/CSC431/metrics')
times = read.csv(file="time.py.csv", quote="'")

times$Compilation <- as.factor(times$Compilation)

texEscape <- function(s) {
  return(gsub('_', '\\\\_', s))
}

f <- function(name) {
  benchmarkTimes <- times[times$Benchmark == name,]
  
  tikz(file = paste('charts/', name ,'.tex', sep=''), width = 4.5, height = 4.5)

  plot = ggplot(benchmarkTimes, aes(x=Compilation, y=Seconds, color=Compilation)) + 
    theme(legend.position = "none") +
    geom_violin(trim = FALSE) +
    geom_jitter(position=position_jitter(0.2)) +
    labs(title=texEscape(name), x = "", y = "Time (s)") + 
    scale_color_brewer(palette = "Dark2") +
    scale_x_discrete(labels = c("clang -O0", "clang -O3", "Optimizations", "Registers", "Stack")) +
    guides(color = FALSE) +
    theme_minimal()
  
  ggsave(file=paste("charts/",name,".png", sep=''), plot=plot, width=10, height=8)
  

  plot
  print(plot)
  dev.off()
  
}

benchmarks <- unique(times$Benchmark)
for (benchmark in benchmarks) {
  f(benchmark)
}
