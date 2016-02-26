# The `zoon` R package for reproducible and shareable species distribution modelling

## Nick Golding, Tom August, Tim C.D. Lucas, Emiel Van Loon & Greg McInerny

### Abstract

1. The diverse array of software and methodological research available for species distribution modelling (SDM) hinder independent evaluation of new methods as well as their dissemination to SDM users.  

2. The `zoon` R package encodes SDM analyses as a simple, but fully reproducible workflow of five steps: obtaining occurrence data, obtaining covariate data, pre-processing these data, fitting a model, and generating outputs.

3. Each of these steps is carried out by one or more community-contributed software modules maintained in a version-controlled online repository.

4. `zoon` workflows are re-runnable records of the data, code and results of an entire SDM analysis and can be easily reproduced, scrutinized and extended by the whole research community.
 
5. We demonstrate the `zoon` R package by recreating X SDM analyses from published research articles, which readers can interrogate and extend.

### Introduction

<!-- The Problem -->
1. Reproducibility crisis in species distribution modelling (SDM).
Difficult for new SDM users to access latest methods.
Equally difficult for methods developers to disseminate their advances.

<!-- The Solution: ZOOOOOON!  -->
2. The `zoon` R package encodes SDM analyses as a simple workflow of five steps: obtaining occurrence data, obtaining covariate data, pre-processing these data, fitting a model, and generating outputs.
Each of these steps is carried out by one or more community-contributed software modules 
This framework facilitates rapid dissemination of novel SDM methodologies by lowering the bar to creating research software.
`zoon` workflows are re-runnable records of the data, code and results of an entire SDM analysis and can be easily reproduced, scrutinized and extended by the whole research community.
 
<!-- How It Works -->
### Implementing a `zoon` workflow

Modules types (and examples) in a diagram.

Structure of workflow objects:
 - code (all and modules used)
 - output of each module; data, results and intermediate steps
 - recording the session info and package and module versions

Extra stuff workflows do (handle cross validation, run parallel methods/data comparisons).

Things you can do to workflows:
 - visualise the structure
 - execute whole thing from scratch (grabs new data from web)
 - execute from part way through

### Example Applications

We demonstrate the `zoon` R package by recreating two SDM analyses from published research articles in the `zoon` R package and extending them.
We provide the corresponding workflow objects and encourage readers to interrogate and alter these workflows.

#### Re-running a fairly simple SDM, tweaking some different stuff and looking at the results 

#### Repeating a MEE methods comparison 

### Future developments

While the `zoon` R package can be used in isolation, future work will develop an online platform to facilitate exploring contributed modules and workflows.
This platform will also provide an online space to discuss, and openly evaluate, proposed best practices in SDM.
The zoon R package therefore represents the first step towards a more reproducible ecosystem of SDM software. 


