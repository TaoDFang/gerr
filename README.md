# GENEMABR: Gene-set module annotation or gene-set enrichment within a regression based framework

# Introduction

GENEMABR is  an R package for gene module annotation or gene set enrichment analysis via a regression based method.
We formulate the gene set enrichment problem within a regression framework. Thus, the problem of gene-set enrichment is transformed into a feature selection problem, where the aim is to select the gene sets that best predict the membership of genes in a given gene set/module.
Here we propose to apply regularised regression methods, such as lasso (l1 regularization), ridge (l2 regularization), or elastic net (hybrid of l1 and l2 regularization controlled by the hyperparameter alpha), in order to adjust the treatment of similar or redundant gene sets.
For more details about this method. Please refer to out paper:(?)

# Installation Instructions

To install the most recent release of GENEMABR (R >= 3.6) via devtools:
 ```R
 library(devtools)
 install_github("TaoDFang/GENEMABR")
 ```

 To install GENEMABR via bioConductor:

# Examples and vignettes

Check .html or .Rmd format files in  vignettes folder
