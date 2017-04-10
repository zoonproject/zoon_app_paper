### Response to reviewers

Thank you very much for the rapid and detailed assessment of our manuscript. We'd like to thanks the AE and reviewers for their positive comments, enthusiasm and very helpful suggestions, all of which have been taken on board in this revision. I have detailed our responses to these suggestions below, with text additions in boldface. I have also corrected all of the typos flagged during the review process (those corrections are not detailed here).

Nick Golding, on behalf of the authors.

#### Reviewer 1 comments in email:

> "For example: add to the manuscript an attachment with the methods to build "modules"."

The zoon R package provides three vignettes, including a 4000-word vignette on how to build modules. We would rather users access this vignette via the package or the package's CRAN page than include it as a supplement, since that version can be updated along with future versions of the package (the vignette as at this release is also archived there). We have added the following sentence to the section *Example 2. Building a spatial thinning module* to refer explicitly to this vignette:

"**The zoon package vignette *Building modules* provides full details and examples of how to build modules of each type.**"

> "Finally, I want to make a mention to the platform to share data. The rights acquired by journals to publications that are not open access. This could generate some kind of legal conflict. It would be appropriate to mention something about the manuscript."

Like the reviewer, we envision that workflows representing whole analyses could be shared as supplementary material to journal articles. Even for paywalled publications, these supplementary materials are typically hosted by journals outside the paywall, so can be made freely available. Moreover, paywalled journals may hold the copyright for a manuscript, but not for the analytical results themselves, so authors are free to share analytical code and data, for example on online platforms such as figshare. We feel that discussing this second point would be out of place in this article, but we have amended the manuscript to clarify the point about supplementary information:

"**Workflow objects could therefore be provided as supplementary information to journal articles, or hosted online to meet journal requirements for public archiving of data and software.**"

##### Comments on pdf:

> P5: "I wonder, at the time of reading this sentence, can anyone contribute? Any type of filter or selection? Otherwise (eg, data cleaning) still have the same limitations."
>
> P11: "Is the data filtered in any way? If so, it should be mentioned here. Criteria for uploading the data. To homogenize it."

These are important points, also noted by Reviewer 2. The section *Exploring available modules* has now been slightly expanded to address these related issues, as follows:

"**The only pre-requisite for uploading a module to the online repository is that it passes a series of automated unit and integration tests to ensure interoperability with other modules. Similarly to the CRAN archive of R packages, zoon leaves the SDM community to determine which methods and software should be used, rather than acting as a gatekeeper of SDM methods.**

A web service for interactive exploration of available modules and their documentation **is currently being developed. This platform may include systems by which users can discuss and rate different modules, making it easier for the community to promote the best modules, flag methodological issues, and collaborate on module development.**"

> P9: "This sentence is the Appify definition, right ?. It is not clear."

The text has been edited to read:

"... in three Shiny apps **(created by the `Appify` module)** allowing the user ..."

> P10: "This function is interesting and valuable for the scientific community. However, how do you handle the rights acquired by the Journal on the results they would be sharing on this platform?"

Resolved as per second comment above.

> P10: "I just checked on the R Page, and it would be interesting to include as an attachment the basic steps to create the different modules that appear on that website."

Resolved as per first comment above.

> P12: "Is there a function to export maps in ASCII formats?"

We have added a sentence as follows:

"**Various other output modules could be used at this point, for example to validate models, project distributions to new regions, or output predictions in a variety of formats.**"



#### Reviewer 2 comments:

>  "First, there needs to be a clear definition of what a module is. For example, it wasn’t necessarily obvious that the modelling modules are not drawing directly from modelling functions already available (i.e. ‘randomForest’ vs ‘RandomForest’). Particularly, as people upload more modules with their own naming schemes, it may not be clear for less experienced users what the difference are and what the consequences of these differences could be for their analyses."

Thank you for highlighting this gap in the write up. We have added the following to the *Building a workflow* section, which introduces modules.

"Each of these steps is encoded as one or more software modules **(snippets of R code) to complete one of these tasks. zoon modules can use methods from any R package, providing a common interface between the many SDM packages already available.**"

The potential issue of multiple similarly-named modules is closely related to reviewer 1's comment about filtering and exploring modules. In our edits in response to that comment, we discuss plans for a web platform where module developers and discuss, rate, and collaborate on modules. Ultimately, we expect the SDM community will be able to promote the best modules and ensure they are used, as happens already with R packages.

>  "Secondly, there is no obvious quality control of the modules that people might draw on. Are there going to be mechanisms by which errors in code are reported? Is this going to be managed through self-policing? I think a discussion of this is required."

This has been addressed by adding text to the section *Exploring available modules*, as detailed in response to Reviewer 1. The new text explains the existing testing of code, the philosophy of the modules repository, and plans for a web platform to make community discussion of modules easier.

> "Finally, I think the authors may have missed an opportunity. An additional step in the workflow for testing if models are fit-for-purpose would be extremely beneficial i.e. testing model residuals forspatial autocorrelation, testing variables for excessive correlation, are the sample sizes large enough given the number of covariates, and are all the models in an ensemble useful. These are important considerations when fitting SDMs, and are far too often overlooked, particularly in packages such as ‘BioMod2’ and ‘sdm’. If we want to widen up the accessibility of SDMs beyond core modellers and improve their application by the less experienced, packages that aim to improve ease of use need to also offer opportunities for testing if a model has been fitted correctly. I understand that this will be a significant undertaking, but should be something that the authors consider, discuss, and potentially implement in a future version of the package."

We agree that automated checking and validation of analyses is an important and under-appreciated aspect of SDM modelling, and something that zoon could help to improve. Rather than adding an additional module type to zoon, such checks would be best handled via output modules. We as the developers of zoon do not want to be seen as dictating which methods are 'correct', but would prefer this be determined by consensus of the SDM community. We would therefore welcome the development by other parties of output modules that check whether workflows are fit for purpose. We have highlighted this opportunity in the Discussion, below an existing related paragraph:

"By providing a common interface for SDM and the capacity to create and share methodological experiments zoon offers a new opportunity for the SDM community to develop community modelling benchmarks, and resolve scientific and methodological questions in ways that the current culture of publishing cannot achieve.

**zoon also has the potential to improve methodological standards in SDM, a research area in which there is widespread misunderstanding and misuse of techniques (Yackulic *et al.* 2013). SDM methodologists could encode model validation procedures and best-practice guidance as zoon output modules, enabling end users to rapidly ensure their modelling procedures are fit-for-purpose (Guillera-Arroita *et al.* 2015).**"

> "Figure 1: What’s the difference between the grey and the black lines? Why in Figure 1C does the line come out of the bottom of the second process icon? Am I missing something?"

The colour and orientation of the arrows are stylistic and simply intended to focus the reader on the relevant part of each diagram. Black lines are used to highloght the inputs and outputs of the module type which lists and chains are being applied. In Figure 1C the line goes out of the bottom of the box for symmetry with the black line going into the box. We believe these choice help make this an engaging figure, and need not be detailed in the figure caption.
