# gerr: Gene-set module annotation or gene-set enrichment within a regression based framework

# Introduction

gerr (Gene-set Enrichment with Regularized Regression) is  an R package for gene module annotation or gene set enrichment analysis via a regression based method.
We formulate the gene set enrichment problem within a regression framework. Thus, the problem of gene-set enrichment is transformed into a feature selection problem, where the aim is to select the gene sets that best predict the membership of genes in a given gene set/module.
Here we propose to apply regularised regression methods, such as lasso (l1 regularization), ridge (l2 regularization), or elastic net (hybrid of l1 and l2 regularization controlled by the hyperparameter alpha), in order to adjust the treatment of similar or redundant gene sets.
For more details about this method. Please refer to out paper:(?)

# Installation Instructions

To install the most recent release of gerr (R >= 3.5) via devtools:
 ```R
 library(devtools)
 install_github("TaoDFang/gerr")
 ```

 To install gerr via bioConductor:
 Not for now


When you load library by library(gerr)
if you see error:
Error in fetch(key) :
  lazy-load database '/Library/Frameworks/R.framework/Versions/3.6/Resources/library/gerr/help/gerr.rdb' is corrupt

You can restart R session to solve the problem

# Examples and vignettes

Check pdf format file in  vignettes folder
