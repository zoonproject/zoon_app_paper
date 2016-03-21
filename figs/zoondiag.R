# code to construct a simple diagram of the workflow layout
# because the output is html, I can't find a programmatic way to convert to
# a static image format for inclusion in the pdf.
# Instead, I'm running this in RStudio, and manually saving as png

library(DiagrammeR)

grViz("
      digraph DAG {
      
      # Intialization of graph attributes
      graph [overlap = true]
      
      # Initialization of node attributes
      node [
        shape = box,
        fontname = Helvetica,
        color = DimGray,
        type = box,
        width = 1.2,
        fixedsize = true,
        style = filled,
        penwidth = 0.5
      ]
      
      # Node statements
      occurrence [fillcolor = LightBlue]
      covariate [fillcolor = LightGreen]
      process [fillcolor = LightGray]
      model [fillcolor = lightsalmon]
      output [fillcolor = wheat]


      # Initialization of edge attributes
      edge [
        color = DimGray,
        rel = yields,
        arrowsize = 0.8
      ]
      
      # Edge statements
      occurrence->process; covariate->process; process->model; model->output
      
      }
      ")
