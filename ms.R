## ----knitrOpts, echo = FALSE, cache = FALSE, eval = TRUE-----------------
# set up knitr options
knitr::opts_chunk$set(fig.path = 'figs/',
               message = FALSE,
               warning = FALSE,
               fig.align = 'center',
               dev = c('png'),
               cache = TRUE)

## ----raster_dir, echo = FALSE, cache = FALSE, eval = TRUE----------------
# set a place for the rasters to be downloaded to (to stop them being grabbed
# again each time)
raster_dir <- './raster_data'
if (!dir.exists(raster_dir)) dir.create(raster_dir)
options("rasterDataDir" = raster_dir)

## ----plotworkflow, eval = FALSE, echo = TRUE-----------------------------
## mosquito1 <- workflow(occurrence = UKAnophelesPlumbeus,
##                       covariate  = UKBioclim,
##                       process    = Background(n = 500),
##                       model      = MaxEnt,
##                       output     = InteractiveMap)

## ----workflow2, eval = FALSE, echo = TRUE--------------------------------
## mosquito2 <- workflow(occurrence = UKAnophelesPlumbeus,
##                       covariate  = UKBioclim,
##                       process    = Chain(Background(n = 500),
##                                          StandardiseCov),
##                       model      = list(MaxEnt,
##                                         GBM,
##                                         RandomForest),
##                       output     = Appify)

## ----loadzoon, eval = TRUE, echo = FALSE, cache = FALSE------------------
# Keep cache = FALSE. Not supposed to cache chunks with library()
#  I assume we want this not echoed.
library(zoon)

set.seed(1633)


## ----fengworkflow, eval = TRUE, dpi = 600, fig.show = "hide", results = "hide", message = FALSE, fig.height = 7, fig.width = 9----
FengPapes <- 
  workflow(occurrence = SpOcc('Dasypus novemcinctus',
                              extent = c(-130, -20, -60, 60)),
           covariate = Bioclim(extent = c(-130, -20, -60, 60),
                               layers = c(1:4, 6, 9, 10, 12, 15)),
           process = Chain(Clean, 
                           MESSMask,  
                           Background(n = 10000,
                                      bias = 200), 
                           Crossvalidate(k = 5)),
           model = MaxEnt,
           output = PrintMap(points = FALSE,
                             threshold = 0.05,
                             thresholdmethod = 'falsenegative',
                             xlim = c(-130, -70),
                             ylim = c(20, 50)))

## ----fengChangeWorkflow, eval = TRUE, fig.show = "hide", fig.height = 9, fig.width = 7.5, dev.args = list(pointsize = 16)----
FengPapesUpdate <- 
  ChangeWorkflow(workflow = FengPapes,
                   output = Chain(ResponseCurve(cov = 1),
                                  InteractiveMap)) 

## ----combinefengupdate, eval = TRUE, echo = FALSE, dpi = 600, fig.show = "hide", fig.height = 4.5, fig.width = 4.5----
# combine the static and interactive maps and first effect plot
# load both images
r_map1 <- brick('figs/fengworkflow-1.png')
r_map <- brick('figs/interactive_map.png')
r_resp <- raster('figs/fengChangeWorkflow-1.png')
r_resp <- brick(r_resp, r_resp, r_resp)

# set up layout so that heights are the same for all panels
plot_height <- min(nrow(r_map1), nrow(r_map), nrow(r_resp))

# get rescaling factor for each
rescale_map1 <- plot_height / nrow(r_map1)
rescale_map <- plot_height / nrow(r_map)
rescale_resp <- plot_height / nrow(r_resp)

# get widths
width_map1 <- ncol(r_map1) * rescale_map1
width_map <- ncol(r_map) * rescale_map
width_resp <- ncol(r_resp) * rescale_resp

# set up layout (maximum total of 200 columns) with a gap in between
# mar won't work for these
gap <- 2

# top row: map1 and resp
widths_top <- c(width_map1, width_resp)
widths_top <- round(widths_top * ((200 - (1 * gap)) / sum(widths_top)))
widths_top <- c(widths_top[1], gap, widths_top[2])

top_row <- rep(1:3, widths_top)
bottom_row <- rep(5, length(top_row))

heights <- c(plot_height + 1, plot_height)
heights <- round(heights * ((50 - (1)) / sum(heights)))
heights <- c(heights[1], 1, heights[2])

top_matrix <- do.call(rbind, replicate(heights[1], top_row, simplify = FALSE))
middle_matrix <- matrix(4, nrow = heights[2], ncol = ncol(top_matrix))
bottom_matrix <- matrix(5, nrow = heights[3], ncol = ncol(top_matrix))

mat <- rbind(top_matrix, middle_matrix, bottom_matrix)
layout(mat)

# plot static map
plotRGB(r_map1, maxpixels = Inf)

# add a panel letter
mtext(text = 'A',
        side = 3,
        line = -1.5,
        adj = 0)  

# gap
plot.new()

# plot the response curve
plotRGB(r_resp, maxpixels = Inf,
        scale = max(maxValue(r_resp)))

# add a panel letter
mtext(text = 'B',
        side = 3,
        line = -1.5,
        adj = 0)  

# gap
plot.new()

# plot interactive map
plotRGB(r_map, maxpixels = Inf)

# add a panel letter
mtext(text = 'C',
        side = 3,
        line = -1.5,
        adj = 0)

## ----spthinmodule, eval = TRUE-------------------------------------------
spThin <- function (.data, thin = 50) {
  
  # check these are presence-background data
  stopifnot(all(.data$df$type %in% c('presence', 'background')))
  
  # install & load the package
  zoon::GetPackage('spThin')
  
  # get dataframe & index to presence data
  df <- na.omit(.data$df)
  pres_idx <- which(df$type == 'presence')
  
  # prepare presence data subset and apply thinning
  sub_df <- data.frame(LAT = df$latitude[pres_idx],
                       LONG = df$longitude[pres_idx],
                       SPEC = NA)
  th <- thin(loc.data = sub_df,
             thin.par = thin,
             reps = 1,
             locs.thinned.list.return = TRUE,
             write.files = FALSE,
             write.log.file = FALSE)
  
  # get index to rows in sub_df, update the full dataset and return
  pres_keep_idx <- as.numeric(rownames(th[[1]]))
  .data$df <- rbind(df[pres_idx,][pres_keep_idx, ],
                    df[-pres_idx, ])
  return (.data)
}

## ----buildmodule, eval = TRUE, results = 'hide', fig.keep = 'none'-------
BuildModule(object = spThin,
            type = 'process',
            title = 'Spatial thinning of Presence-only Data',
            description = paste('Apply the stochastic spatial thinning',
                                'algorithm implemented in the spThin',
                                'package to presence data in a',
                                'presence-background dataset'),
            details = paste('Full details of the algorithm are available in',
                            'the open-access article by Aiello-Lammens',
                            'et al. (2015): dx.doi.org/10.1111/ecog.01132'),
            author = 'zoon Developers',
            email = 'zoonproject@gmail.com',
            paras = list(thin = paste('Thinning parameter - the required',
                         'minimum distance (in kilometres) between points',
                         'after applying the thinning procedure')),
            dataType = 'presence-only',
            check = TRUE)

## ----maxent_comparison, dpi = 600, fig.show = "hide", eval = TRUE, out.height = 600, out.width = 600----
MaxEntComparison <- workflow(
  occurrence = CarolinaWrenPO,
  covariate  = CarolinaWrenRasters,
  process    = Chain(SubsampleOccurrence(500),
                     Background(n = 10000),
                     CarolinaWrenValidation),
  model      = list(MaxEnt(args = 'threshold=false'),
                    MaxNet,
                    MaxNet(regmult = 0.005),
                    MaxNet(features = 'l'),
                    MaxNet(regmult = 0.005, features = 'l'),
                    LogisticRegression),
  output     = Chain(PrintMap(points = FALSE),
                     PerformanceMeasures))

## ----maxent_buffer, eval = TRUE, echo = FALSE, dpi = 600, fig.show = "hide", out.height = 7, out.width = 7----

# loop through adding a margin to each of the previous figures
for (i in 1:6) {
  fpath_in <- sprintf('figs/maxent_comparison-%i.png', i)
  fpath_out <- sprintf('figs/maxent_buffer-%i.png', i)
  img <- brick(fpath_in)
  ext <- as.vector(extent(img))

  png(fpath_out,
      width = ncol(img),
      height = nrow(img))
  
  par(oma = rep(0, 4), mar = rep(0, 4))
  plot.new()
  plot.window(xlim = ext[1:2],
            ylim = ext[3:4],
            asp = 1)
  plotRGB(img, maxpixels = Inf, add = TRUE)
  
  dev.off()
}

## ----save_workflows, echo = FALSE, eval = TRUE---------------------------
# save the three workflow objects
save(FengPapes, FengPapesUpdate, MaxEntComparison,
     file = 'zoon_applications_paper_workflows.RData')

## ----maxent_plotting, eval = TRUE, echo = FALSE, dpi = 600, fig.show = "hide", fig.height = 7, fig.width = 9----

# plot the figure to disk, then plot in a separate chunk with a legend
par(mfrow = c(3, 2))

# loop through plotting them
for (i in 1:6) {
  fpath <- sprintf('figs/maxent_buffer-%i.png', i)
  img <- brick(fpath)
  plotRGB(img, maxpixels = Inf)
  mtext(LETTERS[i],
        side = 3,
        line = -1.5,
        adj = 0)
}


## ----maxent_aucs, eval = TRUE, echo = FALSE------------------------------
# AUCs to be embedded in the text below
perflist <- MaxEntComparison$report[seq(2, 12, by = 2)]
AUCs <- sapply(perflist, function(x) x$auc)
names(AUCs) <- c('MaxEnt',
                 'MaxNet',
                 'MaxNet with no regularisation',
                 'MaxNet with only linear features',
                 'MaxNet with only linear features and no regularisation',
                 'Logistic regression')
AUCs <- round(AUCs, digits = 4)

## ----results = 'asis', echo = FALSE--------------------------------------
cat(paste(names(AUCs), AUCs, collapse = '; '))
cat('.')

## ----flow_diagram, echo = FALSE, fig.cap = "Figure 1. The modular SDM structure encoded by a zoon workflow. A) Description of the five module types. B) Flow diagram illustrating how objects are passed between different module types: 'data frame' - an dataframe of occurrence records; 'raster' - a RasterStack object of the covariates; 'model' - a ZoonModel object, generating standardised predictions from a given model. C) The flow diagram implied by chaining two `process' modules. D) The flow diagram implied by listing three 'model' modules. Full details of module inputs and outputs, and the effects of listing and chaining each module type are given in the zoon vignette 'Building a module'."----
knitr::include_graphics("figs/diagrams.png")

## ----feng_papes_plots, cache = FALSE, echo = FALSE, fig.cap = "Figure 2. Outputs of the workflow objects 'FengPapes' and 'FengPapesUpdate'. A) Map of the MaxEnt predicted distribution, with a 5\\% omission rate threshold, by the 'PrintMap' module in the workflow 'FengPapes' which encodes the core of a published analysis. B) A response curve produced by the 'ResponseCurve' module for the first covariate, bio1 in the workflow 'FengPapesUpdate', which modifies the original analysis workflow. C) A screenshot of the interactive map produced by the 'InteractiveMap' modules in the workflow 'FengPapesUpdate', displaying raw occurrence data and predicted distribution over a global map, allowing users to interactively explore their results. White areas are masked due to being in the MESS mask. Any SDM analysis distributed as a zoon workflow can be easily be explored and scrutinized by modifying its output modules using the function 'ChangeWorkflow'."----
knitr::include_graphics("figs/combinefengupdate-1.png")

## ----maxent_plots, cache = FALSE, echo = FALSE, fig.cap = "Figure 3. Prediction of the distribution of the Carolina wren from 6 different models, produced by the workflow 'MaxEntComparison'. A) MaxEnt without threshold features. B) MaxNet with default settings. C) MaxNet without regularisation. D) MaxNet with regularisation but only linear features. E) MaxNet without regularisation and only linear features. F) Logistic regression. MaxNet with full features but no regularisation (C) gave the most local complexity, indicative of overfitting to the data. The models with only linear features (D-F) had a broader distribution, indicative of underfitting. Differences between MaxNet with linear features and no  regularisation (E) and logistic regression (F) are due to the downweighting applied to background data in the former."----
knitr::include_graphics("figs/maxent_plotting-1.png")

