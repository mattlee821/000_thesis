# environment ====
library(dplyr)
metab_list <- read.table("metabolite_labels_list.txt", header = T, sep = "\t")

# source data ====
gdm_white <- read.table("GDM_white.txt", header = T, sep = "\t")
gdm_white$metabolite <- as.character(gdm_white$metabolite)
gdm_white <- left_join(gdm_white, metab_list, by = "metabolite")
gdm_white <- na.omit(gdm_white)

gdm_sa <- read.table("GDM_south_asian.txt", header = T, sep = "\t")
gdm_sa$metabolite <- as.character(gdm_sa$metabolite)
gdm_sa <- left_join(gdm_sa, metab_list, by = "metabolite")
gdm_sa <- na.omit(gdm_sa)

library(circlize)
library(dplyr)
library(ComplexHeatmap)
library(wesanderson)


track_number <- 2
data_per_track <- 2
track2_data1 <- gdm_white
track2_data2 <- gdm_sa
section_column <- 11
label_column <- 14
estimate_column <- 3
pvalue_column <- 4
pvalue_adjustment <- 1
confidence_interval_lower_column <- 5
confidence_interval_upper_column <- 6
legend <- TRUE
track2_label1 <- "White European"
track2_label2 <- "South Asian"
pvalue_label_on <- FALSE
interaction_column <- 7
interaction_threshold <- 0.001
interaction_cex = 0.6
interaction_pch = 8
interaction_col = "black"

# plot ====
pdf("Kurt_GDM.pdf",
    width = 35, height = 35, pointsize = 30)


# Default plot paramaters ====
track1 <- 1 # track 1 is your section header
track2 <- 2 # you start plotting your data on track 2
track3 <- 3
track4 <- 4
x_axis_index <- 1
track_axis_reference <- 0
margins <- c(0.5, 0.5, 0.5, 0.5) * 25 # A numerical vector of the form c(bottom, left, top, right) which gives the number of lines of margin to be specified on the four sides of the plot
start_gap <- 17 # indicates gap at start for Y axis scale, this is a percentage so the larger the number the larger the empty gap
start_degree <- 90 # starting point of the cirlce in degrees (90 is top)
section_track_height <- 0.10 # size of secton header track as percent of whole circle
track_height <- 0.40 # size of track as percentage of whole circle


# Customisable paramaters ====
## Colours
colours <- names(wes_palettes)
discrete_palette <- wes_palette(colours[8], type = "discrete")

## section header specifics
section_fill_colour <- "snow2"
section_text_colour <- "black"
section_line_colour <- "grey"
section_line_thickness <- 1.5
section_line_type <- 1

## reference lines that go around the tracks
reference_line_colour <- "deeppink"
reference_line_thickness <- 1.5
reference_line_type <- 1

## point specifics
point_pch <- 21
point_cex <- 1.5

point_col1 <- "blue"
point_bg1 <- "white"
point_col1_sig <- "white"
point_bg1_sig <- "blue"

point_col2 <- "red"
point_bg2 <- "white"
point_col2_sig <- "white"
point_bg2_sig <- "red"

## confidence intervals
ci_lwd <- 5
ci_lty <- 1
ci_col1 <- "blue"
ci_col2 <- "red"


## y axis specifics
y_axis_location <- "left"
y_axis_tick <- FALSE
y_axis_tick_length <- 0
y_axis_label_cex <- 0.75

## label specifics
label_distance <- 1.5 # distance from track 0 to plot labels
label_col <- "black"
label_cex <- 0.6





# 1. Set up - set up the plotting region and prepare the data used for this ====

## 1.A use the track2_data1 to plot the initial plotting region of the circle
data <- track2_data1

## 1.B prepare the data into a format you want for plotting
### order based on metabolite category (section) and alphabetically within that based on name of the metabolite
data <- data[order(data[[section_column]], data[[label_column]]),]

### add the X column - this is position of values within the track and should be 1:n depedning on number of variables in each section and is based also on individual sections. this will give a number 1-n for each individual metabolite in each section as a position within the section for plotting values.
data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))

### set parameter - this sets the paramater of the sections of the circos plot so that you can plot within individual sections
npercat <- as.vector(table(data[[section_column]]))

### Standardise x axis to 0-1 - each sections X axis runs 0-1 so this has to be done and provides for each section an individual x axis which we use for plotting individual values within sections as opposed to the plot as a whole
getaxis <- function(data) {
  
  for (i in 1:nrow(data)) {
    
    data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
    data$ncat[i]<- data$x[i]/data$n[i]
  }
  return(data)
}

data <- getaxis(data)

### add column that codes sections as numbers so that we can add this into the plot (the whole metabolite category name doesnt fit) - these numbers can then be translated in the legend or figure title
data$section_numbers = factor(data[[section_column]],
                              labels = 1:nlevels(data[[section_column]]))

### set gap for axis
gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap) # creates vector gap which dictates the spacing between sections, and it is 1-n where n is 1 minus the total number of sections you want as dictated by your categories - last number indicates gap at start for Y axis scale, this is a percentage so the larger the number the larger the empty gap

## 1.C Create the plotting area
circos.clear() #start by clearing the plot space ready for a new plot

### set the blank page on which to plot the circle
par(mar = c(0.6,0.5,0.5,0.5)*25,
    cex = 0.8, #magnification of plotting symbols relative to the default
    xpd = NA) #A logical value or NA. If FALSE, all plotting is clipped to the plot region, if TRUE, all plotting is clipped to the figure region, and if NA, all plotting is clipped to the device region. See also clip.

### set the circle page that you will layer on top of the blank page above
circos.par(cell.padding = c(0, 0.5, 0, 0.5),
           start.degree = start_degree, # starting point of the circle
           gap.degree = gap, # gap between two neighbour sections
           track.margin = c(0.012, 0.012), #blank area outside of the plotting area
           points.overflow.warning = FALSE, #this dictates whether warnings will pop up if plots are plotted outside of the plotting region (this is to do with teh plotting region not being circular and instead being rectangular) - keep this as FALSE
           track.height = section_track_height, #height of the circle tracks
           clock.wise = TRUE) #direction to add sections

### layer the circle ontop of the blank page
circos.initialize(factors = data$section_numbers, #circos.initialize startes the plot based on the factors we want plotted, so the factors are the sections of the plot
                  #x = data$ncat, #ncat here acts as xlim=c(0, 1) essentially
                  xlim = c(0,1),
                  sector.width = npercat) #we set the width of each section based on the number of variables within each section as dictated by nperat which we define earlier

# 2. Track 1 - layer on the first track of the plot, this is the section heading track ====
## 2.A create the section headers
circos.trackPlotRegion(factors = data$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                       track.index = track1, #the track you are plotting
                       x = data$ncat, #the x axis is dictated by the number of values in our data set
                       ylim = c(0, 1), #the y axis is set based on the track width you want as it will impact the size of text you can have in this track
                       track.height = 0.05, #size of track as % of whole circle
                       panel.fun = function(x, y) {
                         chr = get.cell.meta.data("sector.index") #dont change as this gathers all of the info you need automatically
                         xlim = get.cell.meta.data("xlim") #dont change as this gathers all of the info you need automatically
                         ylim = get.cell.meta.data("ylim") #dont change as this gathers all of the info you need automatically
                         circos.rect(xlim[1], 0, xlim[2], 1, # n (+ and -) length of track away from centre (low number means smaller) - want it large enough to encompass text
                                     border = NA, #give the track a border
                                     col = section_fill_colour) #colour of track
                         circos.text(mean(xlim), #text location on x axis
                                     mean(ylim), #text location on y axis
                                     chr, #colour of text, default blue
                                     cex = 1, #text size
                                     facing = "outside", #diretion of text
                                     niceFacing = TRUE, #flip so text is readable
                                     col = section_text_colour)
                       },
                       bg.border = NA) #background border colour

## 2.B add the labels for each data point outside the section headers
circos.trackText(factors = data$section_numbers,
                 track.index = track1, #choose labels based on the track we have just made as you can only plot text once a track has been created
                 x = data$ncat, #location on the x axis where we will plot the lables
                 y = data$b * 0 + label_distance, #dictates where the labels are plotted - * 0 to give 0 and then choose how far away from the 0 we want to plot the text (this will be trial and error before you get what works best for your data set)
                 labels = data[[label_column]], #where you are taking the names for the labels from
                 facing = "reverse.clockwise",
                 niceFacing = TRUE, #flip the text so it is readable
                 adj = c(1, 1),
                 col = label_col,
                 cex = label_cex) #size of the text

# 3. Track 2 - the first track with data points ====
### because we are using the same data as that used to make track 1 we dont need to assign the data again and make paramaters for it

## 3.A set the axis bounds for the track
### You need to include both sets of data points if doing multiple points per track
min1 <- round(min(track2_data1[[confidence_interval_lower_column]]), 3)
min2 <- round(min(track2_data2[[confidence_interval_lower_column]]), 3)
track2_axis_min <- round(min(c(min1, min2)), 3)
track2_axis_min <- round(track2_axis_min + (track2_axis_min * 0.1), 1)

max1 <- round(max(track2_data1[[confidence_interval_upper_column]]), 3)
max2 <- round(max(track2_data2[[confidence_interval_upper_column]]), 3)
track2_axis_max <- round(max(c(max1, max2)), 3)
track2_axis_max <- round(track2_axis_max - (track2_axis_min * 0.1), 1)

track2_axis_min_half <- round(track2_axis_min/2, 3)
track2_axis_max_half <- round(track2_axis_max/2, 3)

track2_axis_max <- 0.9
track2_axis_min <- -0.7

## 3.B create the track and plot the confidence intervals
for(i in 1:nlevels(data$section_numbers)){
  data1 = subset(data, section_numbers == i)
  
  circos.trackPlotRegion(factors = data1$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                         track.index = track2, #the track you are plotting
                         x = data1$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                         y = data1$b, #variable you want to plot
                         ylim = c(track2_axis_min, track2_axis_max), #co-ordinates of the Y axis of the track
                         track.height = track_height, #how big is the track as % of circle
                         
                         #Set sector background
                         bg.border = NA,
                         bg.col = NA,
                         
                         #Map values
                         panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code
                           
                           # plot '0' reference line
                           circos.lines(x = x,
                                        y = y * 0 + track_axis_reference,
                                        col = reference_line_colour, #set the 0 line colour to something distinctive
                                        lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                        lty = reference_line_type)
                           
                           # confidence interval
                           circos.segments(x0 = data1$ncat, # x coordinates for starting point
                                           x1 = data1$ncat, # x coordinates for end point
                                           y0 = data1$b * 0 - -(data1[[confidence_interval_lower_column]]), # y coordinates for start point
                                           y1 = data1$b * 0 + data1[[confidence_interval_upper_column]], # y coordinates for end point
                                           col = ci_col1,
                                           lwd = ci_lwd,
                                           lty = ci_lty,
                                           sector.index = i)})}

## 3.C layer on top of the confidence intervals the effect estimates
### points not reaching signfiicance
circos.trackPoints(factors = subset(data, data[[pvalue_column]] > pvalue_adjustment)$section_numbers,
                   track.index = track2,
                   x = subset(data, data[[pvalue_column]] > pvalue_adjustment)$ncat,
                   y = subset(data, data[[pvalue_column]] > pvalue_adjustment)[[estimate_column]],
                   cex = point_cex,
                   pch = point_pch,
                   col = point_col1,
                   bg = point_bg1)
### points reaching significance
circos.trackPoints(factors = subset(data, data[[pvalue_column]] < pvalue_adjustment)$section_numbers,
                   track.index = track2,
                   x = subset(data, data[[pvalue_column]] < pvalue_adjustment)$ncat,
                   y = subset(data, data[[pvalue_column]] < pvalue_adjustment)[[estimate_column]],
                   cex = point_cex,
                   pch = point_pch,
                   col = point_col1_sig,
                   bg = point_bg1_sig)
### interaction points
circos.trackPoints(factors = subset(data, data[[interaction_column]] < interaction_threshold)$section_numbers,
                   track.index = track2,
                   x = subset(data, data[[interaction_column]] < interaction_threshold)$ncat,
                   y = rep(track2_axis_max, nrow(subset(data, data[[interaction_column]] < interaction_threshold))),
                   cex = interaction_cex,
                   pch = interaction_pch,
                   col = interaction_col)


## 3.D add the axis labels
circos.yaxis(side = y_axis_location,
             sector.index = x_axis_index, #the sector this is plotted in
             track.index = track2,
             at = c(track2_axis_min,  track_axis_reference,  track2_axis_max), #location on the y axis as well as the name of the label
             tick = y_axis_tick, tick.length = y_axis_tick_length,
             labels.cex = y_axis_label_cex) #size of text


# 4. Track 2 data 2 - the first track and with a second data point (this track is only used if data_per_track >= 2) ====
if(data_per_track >= 2 ){
  
  ## 4.A assign the data and set the axis bounds of the track
  data <- track2_data2
  
  ## 4.B prepare the data frame for plotting
  ### order the data frame based on the order of track1
  data <- data[order(data[[section_column]], data[[label_column]]),]
  
  ### add the X column - this is position of values within the track and should be 1:n depedning on number of variables in each section and is based also on individual sections. this will give a number 1-n for each individual metabolite in each section as a position within the section for plotting values.
  data$x <- with(data, ave(seq_along(data[[section_column]]), data[[section_column]], FUN=seq_along))
  
  ### set parameter - this sets the paramater of the sections of the circos plot so that you can plot within individual sections
  npercat <- as.vector(table(data[[section_column]]))
  
  ### standardise x axis to 0-1 - each sections X axis runs 0-1 so this has to be done and provides for each section an individual x axis which we use for plotting individual values within sections as opposed to the plot as a whole
  getaxis <- function(data) {
    
    for (i in 1:nrow(data)) {
      
      data$n[i]<-as.numeric(nrow(subset(data, data[[section_column]] == data[[section_column]][i])))
      data$ncat[i]<- data$x[i]/data$n[i]
    }
    return(data)
  }
  
  data <- getaxis(data)
  
  ### add column that codes sections as numbers so that we can add this into the plot (the whole metabolite category name doesnt fit) - these numbers can then be translated in the legend or figure title
  data$section_numbers = factor(data[[section_column]],
                                labels = 1:nlevels(data[[section_column]]))
  
  ### set gap for axis
  gap = c(rep(1, nlevels(data[[section_column]])-1), start_gap) # creates vector gap which dictates the spacing between sections, and it is 1-n where n is 1 minus the total number of sections you want as dictated by your categories - last number indicates gap at start for Y axis scale, this is a percentage so the larger the number the larger the empty gap
  
  ## 4.C create the track and plot the confidence intervals
  for(i in 1:nlevels(data$section_numbers)){
    data1 = subset(data, section_numbers == i)
    
    circos.trackPlotRegion(factors = data1$section_numbers, #we plot the first region based on the column in our data set which we creat the sections from
                           track.index = track2, #the track you are plotting
                           x = data1$ncat, #set this as ncat as ncat dictates the location of the variable you want to plot within each section and within the circle as a whole
                           y = data1$b, #variable you want to plot
                           ylim = c(track2_axis_min, track2_axis_max), #co-ordinates of the Y axis of the track
                           track.height = track_height, #how big is the track as % of circle
                           
                           #Set sector background
                           bg.border = NA,
                           bg.col = NA,
                           
                           #Map values
                           panel.fun = function(x, y) { #this sets x and y as the above defined variables for the following lines of code
                             
                             # plot '0' reference line
                             circos.lines(x = x,
                                          y = y * 0 + track_axis_reference,
                                          col = reference_line_colour, #set the 0 line colour to something distinctive
                                          lwd = reference_line_thickness, #set the thickness of the line so it's a bit smaller than your point (looks better)
                                          lty = reference_line_type)
                             
                             # confidence interval
                             circos.segments(x0 = data1$ncat, # x coordinates for starting point
                                             x1 = data1$ncat, # x coordinates for end point
                                             y0 = data1$b * 0 - -(data1[[confidence_interval_lower_column]]), # y coordinates for start point
                                             y1 = data1$b * 0 + data1[[confidence_interval_upper_column]], # y coordinates for end point
                                             col = ci_col2,
                                             lwd = ci_lwd,
                                             lty = ci_lty,
                                             sector.index = i)})}
  
  ## 4.D layer on top of the confidence intervals the effect estimates
  ### points not reaching signfiicance
  circos.trackPoints(factors = subset(data, data[[pvalue_column]] > pvalue_adjustment)$section_numbers,
                     track.index = track2,
                     x = subset(data, data[[pvalue_column]] > pvalue_adjustment)$ncat,
                     y = subset(data, data[[pvalue_column]] > pvalue_adjustment)[[estimate_column]],
                     cex = point_cex,
                     pch = point_pch,
                     col = point_col2,
                     bg = point_bg2)
  ## points reaching significance
  circos.trackPoints(factors = subset(data, data[[pvalue_column]] < pvalue_adjustment)$section_numbers,
                     track.index = track2,
                     x = subset(data, data[[pvalue_column]] < pvalue_adjustment)$ncat,
                     y = subset(data, data[[pvalue_column]] < pvalue_adjustment)[[estimate_column]],
                     cex = point_cex,
                     pch = point_pch,
                     col = point_col2_sig,
                     bg = point_bg2_sig)}

# 5. Legend - ====

## 5.A - Assign the legend points
legend1 <- Legend(at = c(track2_label1, track2_label2),
                  labels_gp = gpar(fontsize = 24, fontface = "bold"),
                  ncol = 1,
                  border = NA, # color of legend borders, also for the ticks in the continuous legend
                  background = NA, # background colors
                  legend_gp = gpar(col = c("blue", "red" )), # graphic parameters for the legend
                  type = "points", # type of legends, can be grid, points and lines
                  pch = 19, # type of points
                  size = unit(15, "mm"), # size of points
                  grid_height	= unit(15, "mm"),
                  grid_width = unit(15, "mm"),
                  direction = "vertical")

## 5.B - Assign names for legend key
names <- levels(as.factor(data[[section_column]]))
names <- paste(1:nlevels(track2_data1[[section_column]]), names, sep=". ")
legend3 <- Legend(at = names,
                  labels_gp = gpar(fontsize = 24, fontface = "bold"),
                  nrow = 4,
                  ncol = 7,
                  border = NA, # color of legend borders, also for the ticks in the continuous legend
                  background = NA, # background colors
                  legend_gp = gpar(col = c("black")), # graphic parameters for the legend
                  size = unit(15, "mm"), # size of points
                  grid_height	= unit(15, "mm"),
                  grid_width = unit(10, "mm"),
                  direction = "horizontal")

## 5.C - Assign Pvalue legend point
# legend2 <- Legend(at = pvalue_label, # breaks, can be wither numeric or character
#                   labels_gp = gpar(fontsize = 24, fontface = "bold"),
#                   ncol = 1,
#                   border = NA, # color of legend borders, also for the ticks in the continuous legend
#                   background = NA, # background colors
#                   legend_gp = gpar(col = c("black")), # graphic parameters for the legend
#                   type = "points", # type of legends, can be grid, points and lines
#                   pch = 1, # type of points
#                   size = unit(15, "mm"), # size of points
#                   grid_height	= unit(15, "mm"),
#                   grid_width = unit(15, "mm"),
#                   direction = "vertical")

## 5.C - Pack legend without pvalue label
legend <- packLegend(legend1, legend3, direction = "horizontal", gap = unit(0, "mm"))

## 5.D - Pack legend with pvalue label
# legend4 <- ComplexHeatmap::packLegend(legend1, legend2, direction = "vertical", gap = grid::unit(0, "mm"))
# legend <- ComplexHeatmap::packLegend(legend4, legend3, direction = "horizontal", gap = grid::unit(0, "mm"))

## 5.E - Layer legend ontop of plot
pushViewport(viewport(x = unit(0.5, "npc"),
                      y = unit(0.068, "npc"),
                      width = grobWidth(legend),
                      height = grobHeight(legend),
                      just = c("center", "top")))
grid.draw(legend)
upViewport()


dev.off()