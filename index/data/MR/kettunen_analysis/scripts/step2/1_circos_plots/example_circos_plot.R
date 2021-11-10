# An example script for circos plot

# source function
source("002_adiposity_metabolites/scripts/step2/1_circos_plots/my_circos_plot_function.R")

# simulate some data so you can test the script ====
a <- rep("Example", length.out = 123)
b <- 1:123
outcome_name <- paste(a, b, sep="")
outcome_group <- as.factor(rep(LETTERS[1:14], length.out = 123))
outcome_subgroup <- as.factor(rep(1:28, length.out = 123))
beta = rnorm(n = 123, 0, 0.1)
standard_error <- beta/3
Pvalue = runif(n = 123, min = 0, max = 0.1)
lower_confidence_interval <- beta - (1.96 * standard_error)
upper_confidence_interval <- beta + (1.96 * standard_error)
data <- data.frame(outcome_name, outcome_group, outcome_subgroup, beta, standard_error, Pvalue, lower_confidence_interval, upper_confidence_interval)

# set data frames ====
data1 <- data
data2 <- data
data3 <- data


# save plot
pdf("002_adiposity_metabolites/scripts/step2/1_circos_plots/example_circos_plot_v1.pdf",
    width = 35, height = 35, pointsize = 30)

my_circos_plot(track_number = 3, # how many tracks do you want - this should correspond to the number of data frame syou have
               track2_data1 = data1, # the first track you will plot data on
               track3_data1 = data2, # the second track you will plot data on
               track4_data1 = data3, # the third track you will plot data on
               label_column = 1, # what column in your data frame is the labels column
               section_column = 3, # what column in your data frame do you want to group your data by
               estimate_column = 4, # what column in your data frame is the estimate column
               pvalue_column = 6, # what column in your data fram is the Pvalue column
               pvalue_adjustment = 0.05/123, # what Pvalue significance threshold do you want to set, anything below this threshold will be highlighted as 'significant'
               confidence_interval_lower_column = 7, # what column in your data frame is the lower confidence interval column
               confidence_interval_upper_column = 8, # what column in your data frame is the upper confidence interval column
               legend = TRUE, # the legend is always plotted centrally below the circos plot
               track2_label = "data1",
               track3_label = "data2",
               track4_label = "data3",
               pvalue_label = "P > 0.05/123")

dev.off()
