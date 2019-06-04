#' Pretrained lambda values for Gaussian glmnet
#' @format A vector of numeric values
#' @export
pretrained_gaussian_lambda <- c(0.007956622,0.01)

#' Homo sapiens GO ontology tree
#'@description A rds R object contains GO ontology relationships (tree structure)
#'@format Directed igraph format
#'@source http://geneontology.org/docs/download-ontology/
#'@details  The igraph format tree was constructed by using data from http://geneontology.org/docs/download-ontology/ (May 2108)
#'It has three root notes representing Molecular Function,Cellular Component and Biological Process (http://geneontology.org/docs/ontology-documentation/)
"human_go_ontology"


#' human_go_roots
#'@description A rds R object contains GO ontology tree root nodes
#'@format A vector of GO ontology root notes (ID)
#'@source http://geneontology.org/docs/download-ontology/
#'@details  You can view tree stuctor of GO ontology at  https://www.ebi.ac.uk/QuickGO/
#'Thre are three roots notes in GO ontology tree: GO:0008150 (biological_process), GO:0003674(molecular_function), GO:0005575(cellular_component)
"human_go_roots"

#' human_go_sub_roots
#'@description A rds R object contains GO ontology tree sub-root nodes (The children of root nodes).
#'@format A list of three elements contains GO ontology sub-root notes (ID)/the children of three root notes
#'@source http://geneontology.org/docs/download-ontology/
#'@details  You can view tree stuctor of GO ontology at  https://www.ebi.ac.uk/QuickGO/
"human_go_sub_roots"


#' Homo sapiens REACTOME ontology tree
#'@description A rds R object contains Reactome ontology relationships (tree structure)
#'@format Directed igraph format
#'@source https://reactome.org/download-data
#'@details  The igraph format tree was constructed by using  data from https://reactome.org/download-data (May 2108)
#'It has several root nodes representing REACTOME pathway categories (https://reactome.org/PathwayBrowser/)
"human_reactome_ontology"


#' human_reactome_roots
#'@description A rds R object contains REACTOME tree root nodes
#'@format A vector of REACTOME root notes (ID)
#'@source https://reactome.org/download-data
#'@details  You can view tree stuctor of REACTOME at https://reactome.org/PathwayBrowser/
"human_reactome_roots"


#' Homo sapiens GO ontology and REACTOME ontology gene-pathway realtionship
#'@description A rds R object contains GO ontology and REACTOME ontology gene-pathway realtionship
#'@format Formal class 'dgCMatrix' [package "Matrix"]
#'@import Matrix
#'@source http://geneontology.org/docs/download-ontology/, https://reactome.org/download-data
#'A binary matrix whose columns are the pathways/gene sets from GO ontology and REATOME database and
#'whose rows are all the genes(represented by gene HUGO gene symbols) from  GO ontology and REATOME database.
#'For gene i and pathway j, the value of matrix(i,j) is 1 is gene i belonging to pathway j otherwise 0
"gene_pathway_matrix"

#' simGenesets
#' @description A list of gene-sets used for simulation studies
#' @format A list of gene-sets (in the form of character vectors), with gene-set names as the names of the list.
#' @source The \href{https://github.com/igordot/msigdbr}{msigdbr} package, and 
#'   the \href{http://software.broadinstitute.org/gsea/msigdb}{MSigDB: Molecular Signatures Database}
"simGenesets"

#' verifKeyRes
#' @description Key results of model verification
#' @format A list of key results of gerr model verification
#' @details The data was generated once and is cached to reproduce the simulation results in the vignettes.
"verifKeyRes"

#' fisherVerif
#' @description Results of one-sided Fisher's exact test and Benjamini-Hochberg p-value correction
#' @format A list
#' @details The data was generated once and is cached to reproduce the simulation results in the vignettes,
#'   it was used to compare the performance of gerr and FET+FDR procedures
"fisherVerif"

#' fullProbSimResDf
#' @description Full results of simulation studies using the probabilistic generative model of GOIs
#' @format A data.frame
#' @details The data was generated once and is cached to reproduce the simulation results in the vignettes.
#'   Note that due to the stochastic nature of sampling, in some runs, no gene-set is selected to construct 
#'   GOI. They should be filtered out prior to downstream analysis.
"fullProbSimResDf"
