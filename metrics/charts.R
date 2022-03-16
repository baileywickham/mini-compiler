library(tikzDevice)
library(ggplot2)
library(RColorBrewer)
library(xtable)


setwd('C:/Users/alexm/Documents/431/CSC431/metrics')

times = read.csv(file = "time.py.csv", quote ="'")

times$Compilation <- factor(times$Compilation,
                            levels = c('stack.s', 'reg.s', 'opt.s', 'c.o0', 'c.o3'),
                            labels = c("Stack", "Registers",  "Optimizations", "clang -O0", "clang -O3"))

instructions = read.csv(file = "lines.final.csv", quote =" '")

instructions$Format <- factor(instructions$Format,
                            levels = c('ll', 's'),
                            labels = c("LLVM IR", "ARM Assembly"))

instructions$Compilation <- factor(instructions$Compilation,
                            levels = c('stack', 'reg', 'opt'),
                            labels = c("Stack", "Registers",  "Optimizations"))



texEscape <- function(s) {
  return(gsub('_', '\\\\_', s))
}


statsForBenchmark <- function(name) {
  benchmarkTimes <- times[times$Benchmark == name,]

  tikz(file = paste('charts/', name, '.tex', sep = ''), width = 6, height = 5.5)

  plot = ggplot(benchmarkTimes, aes(x = Compilation, y = Seconds, color = Compilation)) +
    theme(legend.position = "none") +
    geom_violin(trim = FALSE) +
    geom_jitter(position = position_jitter(0.3)) +
    labs(title = "real execution time on \\texttt{input.longer}", x = "", y = "Time (s)") +
    scale_color_manual(values = c("#8c96c6", "#8856a7", "#810f7c", "#2ca25f", "#006d2c")) +
    guides(color = FALSE) +
    theme_minimal() +
    ylim(0, NA)

  ggsave(file = paste("charts/images/", name, ".png", sep = ''),
         plot = plot, width = 10, height = 8)

  plot
  print(plot)
  dev.off()

  rawTable <- aggregate(benchmarkTimes$Seconds,
                       list(benchmarkTimes$Compilation), FUN = summary)
  print(rawTable)
  summaryTable <- rawTable[[2]]
  row.names(summaryTable) <- rawTable[[1]]
  print(xtable(summaryTable, type = "latex"),
        file = paste("charts/", name, "Table.tex" , sep = ''))


  rawInstTable <- reshape(instructions[instructions$Benchmark == name, -1],
                          idvar="Compilation", timevar = "Format", direction = 'wide')
  names(rawInstTable) <- c("Compilation", "LLVM IR", "ARM Assembly")
  row.names(rawInstTable) <- rawInstTable$Compilation
  instTable <- rawInstTable[order(rawInstTable$Compilation), c(2,3)]
  print(xtable(instTable, type = "latex"),
        file = paste("charts/", name, "InstTable.tex" , sep = ''))
}


benchmarks <- unique(times$Benchmark)
for (benchmark in benchmarks) {
  statsForBenchmark(benchmark)
}
