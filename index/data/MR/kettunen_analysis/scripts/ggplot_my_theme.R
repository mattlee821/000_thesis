my_theme <- function () 
  { 
  ggplot2::theme(
    
    # high level arguments
    
    ## line - all line elements (element_line())
    line = element_line(colour = "black",
                        size = 0.5,
                        linetype = 1,
                        lineend = "butt",
                        arrow = FALSE),

    ## rectangular - all rectangular elements (element_rect())
    rect = element_rect(fill = NULL,
                        colour = NULL,
                        size = 0.5,
                        linetype = 1),
    
    ## text - all text elements (element_text())
    text = element_text(family = "Helvetica",
                        size = 11,
                        hjust = 0.5,
                        vjust = 0,
                        face = "bold",
                        color = "#222222"),
    
    ## title - all title elements: plot, axes, legends (element_text(); inherits from text)
    title = element_text(family = "Helvetica",
                         size = 11,
                         hjust = 0.5,
                         vjust = 0,
                         face = "bold",
                         color = "#222222"),
    ## margin
    #margin = margin(t = 5.5, r = 5.5, b = 5.5, l = 5.5, unit = "pt"),    
    
    
    # axis
    
    ## title - labels of axes (element_text()). Specify all axes' labels (axis.title), labels by plane (using axis.title.x or axis.title.y), or individually for each axis (using axis.title.x.bottom, axis.title.x.top, axis.title.y.left, axis.title.y.right). axis.title.*.* inherits from axis.title.* which inherits from axis.title, which in turn inherits from text
    axis.title = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"), 
    axis.title.x = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"),
    axis.title.y = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"),
    axis.title.x.top = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"),
    axis.title.x.bottom = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"),
    axis.title.y.left = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"),
    axis.title.y.right = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"),
    
    ## text of tick labels - tick labels along axes (element_text()). Specify all axis tick labels (axis.text), tick labels by plane (using axis.text.x or axis.text.y), or individually for each axis (using axis.text.x.bottom, axis.text.x.top, axis.text.y.left, axis.text.y.right). axis.text.*.* inherits from axis.text.* which inherits from axis.text, which in turn inherits from text
    axis.text = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"), 
    
    ## ticks - tick marks along axes (element_line()). Specify all tick marks (axis.ticks), ticks by plane (using axis.ticks.x or axis.ticks.y), or individually for each axis (using axis.ticks.x.bottom, axis.ticks.x.top, axis.ticks.y.left, axis.ticks.y.right). axis.ticks.*.* inherits from axis.ticks.* which inherits from axis.ticks, which in turn inherits from line
    axis.ticks = element_line(colour = "black", size = 0.5, linetype = 1, lineend = "butt", arrow = FALSE),
    
    ## tick length - length of tick marks (unit)
    axis.ticks.length = unit(2.75, "pt"),
    
    ## axis lines - lines along axes (element_line()). Specify lines along all axes (axis.line), lines for each plane (using axis.line.x or axis.line.y), or individually for each axis (using axis.line.x.bottom, axis.line.x.top, axis.line.y.left, axis.line.y.right). axis.line.*.* inherits from axis.line.* which inherits from axis.line, which in turn inherits from line
    axis.line = element_blank(),
   
    
    # legend

    ## background - background of legend (element_rect(); inherits from rect)
    legend.background = element_blank(),

    ## margin - the margin around each legend (margin())
    legend.margin = margin(t = 5.5, r = 5.5, b = 5.5, l = 5.5, unit = "pt"),

    ## spacing - the spacing between legends (unit). legend.spacing.x & legend.spacing.y inherit from legend.spacing or can be specified separately
    legend.spacing = unit(11, "pt"),
    legend.spacing.x = unit(11, "pt"),
    legend.spacing.y = unit(11, "pt"),
    
    ## key - background underneath legend keys (element_rect(); inherits from rect)
    legend.key = element_rect(fill = NULL, colour = NULL, size = 0.5, linetype = 1),

    ## key size - size of legend keys (unit); key background height & width inherit from legend.key.size or can be specified separately
    legend.key.size = unit(1.2, "pt"),
    legend.key.height = unit(1.2, "pt"),
    legend.key.width = unit(1.2, "pt"),
    
    ## text - legend item labels (element_text(); inherits from text)
    legend.text = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"), 

    ## text alignment - alignment of legend labels (number from 0 (left) to 1 (right))
    legend.text.align = 0, 
    
    ## title - title of legend (element_text(); inherits from title)
    legend.title = element_text(family = "Helvetica", size = 11, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"), 

    ## title alignment - alignment of legend title (number from 0 (left) to 1 (right))
    legend.title.align = 0.5,
    
    ## position - the position of legends ("none", "left", "right", "bottom", "top", or two-element numeric vector)
    legend.position = "bottom", #c(0.5,0)

    ## direction - layout of items in legends ("horizontal" or "vertical")
    legend.direction = "horizontal",
    
    ## justification - anchor point for positioning legend inside plot ("center" or two-element numeric vector) or the justification according to the plot area when positioned outside the plot
    legend.justification = "center", # c(0.5,0.5)

    ## multiple legends 
    ### arrnagement - arrangement of multiple legends ("horizontal" or "vertical")
    legend.box = "horizontal",
    
    ### justification - justification of each legend within the overall bounding box, when there are multiple legends ("top", "bottom", "left", or "right")
    legend.box.just = "top",

    ### margin - margins around the full legend area, as specified using margin()
    legend.box.margin = margin(t = 5.5, r = 5.5, b = 5.5, l = 5.5, unit = "pt"),
    
    ### background - background of legend area (element_rect(); inherits from rect)
    legend.box.background = element_blank(),
    
    ### spacing - The spacing between the plotting area and the legend box (unit)
    legend.box.spacing = unit(11, "pt"),
    
    
    # panel
    
    ## background - # background of plotting area, drawn underneath plot (element_rect(); inherits from rect)
    panel.background = element_blank(), 
    
    ## border - border around plotting area, drawn on top of plot so that it covers tick marks and grid lines. This should be used with fill = NA (element_rect(); inherits from rect)
    panel.border = element_blank(), 
    
    ## spacing - spacing between facet panels (unit). panel.spacing.x & panel.spacing.y inherit from panel.spacing or can be specified separately.
    panel.spacing = unit(5.5, "pt"),
    panel.spacing.x = unit(5.5, "pt"),
    panel.spacing.y = unit(5.5, "pt"),
    
    ## grid - grid lines (element_line()). Specify major grid lines, or minor grid lines separately (using panel.grid.major or panel.grid.minor) or individually for each axis (using panel.grid.major.x, panel.grid.minor.x, panel.grid.major.y, panel.grid.minor.y). Y axis grid lines are horizontal and x axis grid lines are vertical. panel.grid.*.* inherits from panel.grid.* which inherits from panel.grid, which in turn inherits from line
    panel.grid  = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    
    # option to place the panel (background, gridlines) over the data layers (logical). Usually used with a transparent or blank panel.background.
    panel.ontop = FALSE,
    
    
    # plot
    
    ## background - background of the entire plot (element_rect(); inherits from rect)
    plot.background = element_blank(),

    ## title - plot title (text appearance) (element_text(); inherits from title) left-aligned by default
    plot.title = element_text(family = "Helvetica", size = 16, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"), 
    
    ## subtitle - plot subtitle (text appearance) (element_text(); inherits from title) left-aligned by default
    plot.subtitle = element_text(family = "Helvetica", size = 14, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"), 
    
    ## caption - caption below the plot (text appearance) (element_text(); inherits from title) right-aligned by default
    plot.caption = element_text(family = "Helvetica", size = 8, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"),
    
    ## tag - upper-left label to identify a plot (text appearance) (element_text(); inherits from title) left-aligned by default
    plot.tag = element_text(family = "Helvetica", size = 8, hjust = 0.5, vjust = 0, face = "bold", color = "#222222"),

    ## tag position - The position of the tag as a string ("topleft", "top", "topright", "left", "right", "bottomleft", "bottom", "bottomright) or a coordinate. If a string, extra space will be added to accommodate the tag.
    plot.tag.position = "topleft",
    
    ## margin - margin around entire plot (unit with the sizes of the top, right, bottom, and left margins)
    plot.margin = margin(t = 5.5, r = 5.5, b = 5.5, l = 5.5, unit = "pt"),
   
    
    # strip (used when facetting a plot)

    ## background - background of facet labels (element_rect(); inherits from rect). Horizontal facet background (strip.background.x) & vertical facet background (strip.background.y) inherit from strip.background or can be specified separately
    strip.background = element_blank(),
    strip.background.x = element_blank(), 
    strip.background.y = element_blank(),

    # placement - placement of strip with respect to axes, either "inside" or "outside". Only important when axes and strips are on the same side of the plot.
    strip.placement = "inside",
    
    # text - facet labels (element_text(); inherits from text). Horizontal facet labels (strip.text.x) & vertical facet labels (strip.text.y) inherit from strip.text or can be specified separately
    strip.text = element_text(family = "Helvetica", size = 11, hjust = 0, vjust = 0, angle = 0, face = "bold", color = "#222222"),
    strip.text.x = element_text(family = "Helvetica", size = 11, hjust = 0, vjust = 0, angle = 0, face = "bold", color = "#222222"),
    strip.text.y = element_text(family = "Helvetica", size = 11, hjust = 0, vjust = 0, angle = 0, face = "bold", color = "#222222"),
    
    # padding - space between strips and axes when strips are switched (unit)
    strip.switch.pad.grid = unit(2.75, "pt"),
    
    # padding - space between strips and axes when strips are switched (unit)
    strip.switch.pad.wrap = unit(2.75, "pt")
  )
}
