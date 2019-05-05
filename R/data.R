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
#'@source http://geneontology.org/docs/download-ontology/, https://reactome.org/download-data
#'A binary matrix whose columns are the pathways/gene sets from GO ontology and REATOME database and
#'whose rows are all the genes(represented by gene HUGO gene symbols) from  GO ontology and REATOME database.
#'For gene i and pathway j, the value of matrix(i,j) is 1 is gene i belonging to pathway j otherwise 0
"gene_pathway_matrix"

