# The `zoon` R package for reproducible and shareable species distribution modelling

## Nick Golding, Tom August, Tim C.D. Lucas, Emiel Van Loon & Greg McInerny

### Abstract

1. The diverse array of software and methodological research available for species distribution modelling (SDM) hinder independent evaluation of new methods as well as their dissemination to SDM users.  

2. The `zoon` R package encodes SDM analyses as a simple, but fully reproducible workflow of five steps: obtaining occurrence data, obtaining covariate data, pre-processing these data, fitting a model, and generating outputs.

3. Each of these steps is carried out by one or more community-contributed software modules maintained in a version-controlled online repository.

4. `zoon` workflows are re-runnable records of the data, code and results of an entire SDM analysis and can be easily reproduced, scrutinized and extended by the whole research community.
 
5. We demonstrate `zoon` by recreating SDM analyses from two published research articles as zoon workflows, which readers can interrogate and extend.

### Introduction

<!-- The Problem -->
Reproducibility crisis in species distribution modelling (SDM).
Difficult for new SDM users to access latest methods.
Equally difficult for methods developers to disseminate their advances.

<!-- The Solution: ZOOOOOON!  -->
The `zoon` R package encodes SDM analyses as a simple workflow of five steps: obtaining occurrence data, obtaining covariate data, pre-processing these data, fitting a model, and generating outputs.
Each of these steps is carried out by one or more community-contributed software modules 
This framework facilitates rapid dissemination of novel SDM methodologies by lowering the bar to creating research software.
`zoon` workflows are re-runnable records of the data, code and results of an entire SDM analysis and can be easily reproduced, scrutinized and extended by the whole research community.
 
<!-- How It Works -->
### Implementing a `zoon` workflow

Module types (and examples) in a diagram (Figure 1).

![The modular SDM structure encoded by a zoon workflow.
A) Flow diagram representing the module types.
B) The required inputs and outputs for each module types (full details given in the `zoon` vignette 'Building a module').
C) Chaining and listing modules of the same type.
D) An example workflow, corresponding to Example 1 below.](./figs/workflow_schematic.pdf)

Structure of workflow objects:

* code (call and modules used)
* output of each module; data, results and intermediate steps
* recording the session info and package and module versions

Extra stuff workflows do (handle cross validation, run parallel methods/data comparisons).

Things you can do to workflows:

* visualise the structure
* execute whole thing from scratch (grabs new data from web)
* execute from part way through

### Example Applications

We demonstrate the `zoon` R package by recreating two SDM analyses from published research articles in the `zoon` R package and extending them.
Workflow objects which complete replicate these analyses can be accessed at [http://figshare.com/articles/zoon_applications_paper_workflows](http://figshare.com/articles/zoon_applications_paper_workflows).
We encourage readers to download, interrogate and alter these workflows for themselves.
Full code and metadata for all of the modules used in the examples below, can be found at [https://github.com/zoonproject/modules/R](https://github.com/zoonproject/modules/R)

#### Re-running a fairly simple SDM, tweaking some different stuff and looking at the results 

Explanation & citation

One of the modules we had to write:

```r
AwesomeModule <- function(.df) {
    something
    return (something else)
}
```


What the workflow looks like

```r
carruthers_et_al <- workflow(
    occurrence = ...,
    covariate = ...,
    process = ...,
    model = ...,
    output = ...)
```

Some tweak we did to it:

```r
carruthers_et_al_interactive <- ReRunWorkflow(
    carruthers_et_al,
    output = InteractiveMap)
```

Some plottable results of this analysis 

#### Repeating a MEE methods comparison 


Explanation & citation

One of the modules we had to write:

```r
AnotherAwesomeModule <- function(.df) {
    something
    return (something else)
}
```


What the workflow looks like:

```r
whitstanley_et_al <- workflow(
    occurrence = ...,
    covariate = ...,
    process = ...,
    model = ...,
    output = ...)
```

So we added an additional model and an additional evaluation criterion and re-ran it:

```r
whitstanley_et_al_interactive <- ReRunWorkflow(
    whitstanley_et_al,
    model = list(..., MaxEnt),
    output = Chain(..., SomethingNew))
```

### Future developments

Tutorials on how to create workflows and modules, as well as full technical details for module developers, are provided as vignettes distributed with `zoon`.

While the `zoon` R package can be used in isolation, future work will develop an online platform to facilitate exploring contributed modules and workflows.
This platform will also provide an online space to discuss, and openly evaluate, proposed best practices in SDM.
The zoon R package therefore represents the first step towards a more reproducible ecosystem of SDM software. 


