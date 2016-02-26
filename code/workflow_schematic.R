# make figure 1, stick it in ./figs

# set up device
pdf('figs/workflow_schematic.pdf',
    width = 6,
    height = 2)

# set up plotting window
plot.new()
par(mar = rep(0, 4))
plot.window(0:1, 0:1)

# grey rectangle (no background in vector pdf?)
rect(-1, -1, 2, 2, col = grey(0.9), border = NA)

# text over the top
text(0.5, 0.5, 'PLACEHOLDER',
     col = grey(0.3),
     cex = 3,
     xpd = NA)

# close the plotting device
dev.off()
