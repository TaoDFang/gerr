#' regression_selected_pathways
#'
#' This function allows you to extracte enriched pathways for gene module/list via regressioin (elastic net) based method
#' @param gene_input A vecor of genes to be annotated. It should have same ID types(Ensembl ID, HUGO gene symbol) as the genes in \emph{gene_pathway_matrix}.
#' @param gene_pathway_matrix A binary background matrix whose columns are the pathways/gene sets and 
#'whose rows are all the genes from pathways/gene sets . It could be in sparse matrix format ((inherit from class "sparseMatrix" as in package Matrix) to save memory.
#'For gene i and pathway j, the value of matrix(i,j) is 1 is gene i belonging to pathway j otherwise 0.
#'Users could leave it as default value("default") so it will use pre-collected gene_pathway_matrix from GO Ontology and REACTOME databaase.
#'Otherwise, they could use their own customized gene_pathway_matrix 
#' @param lambda We use glmnet function to do regression. \emph{lambda} is an argument in \strong{glmnet}. See \strong{glmnet} function for more details
#' Here we use default value 0.007956622 after preliminary study. It can be overridden by giving \emph{nlambda} and \emph{lambda.min.ratio arguments}.
#' @param alpha The elasticnet mixing parameter, with 0≤α≤ 1. The penalty is defined as
#'(1-α)/2||β||_2^2+α||β||_1.
#'alpha=1 is the lasso penalty, and alpha=0 the ridge penalty. Default value: 0.5.
#' @param ... Other paramaters for glmnet function.
#' @return  A list of four elements: 
#' \itemize{
#'   \item selected_pathways_names - Pathways names for selected pathways
#'   \item selected_pathways_coef - Regression coefficients value for selected pathways
#'   \item selected_pathways_fisher_pvalue - Fisher exact pvalue for selected pathways
#'   \item selected_pathways_num_genes - The number of genes for selected pathways in background
#' }
#' @keywords 
#' @export
#' @examples
#' a=regression_selected_pathways(gene_input =c("TRPC4AP","CDC37","TNIP1","IKBKB","NKIRAS2","NFKBIA","TIMM50","RELB","TNFAIP3","NFKBIB","HSPA1A","NFKBIE","SPAG9","NFKB2","ERLIN1","REL","TNIP2","TUBB6","MAP3K8"),gene_pathway_matrix="default",lambda=0.007956622,alpha=0.5)
regression_selected_pathways=function(gene_input,gene_pathway_matrix="default",lambda=0.007956622,alpha=0.5,...){
  #library(glmnet)
  addi_args=list(...)
  if(gene_pathway_matrix=="default"){
     gene_pathway_matrix=readRDS(system.file("extdata", "gene_pathway_matrix.rds", package = "GENEMABR"))
   }
  
  all_genes=rownames(gene_pathway_matrix)
  all_pathways=colnames(gene_pathway_matrix)
  
  module_labels=rep(0,length(all_genes))          #len:20244F
  names(module_labels)=all_genes
  module_common_genes=intersect(all_genes,gene_input) 
   
  if(length(module_common_genes)>1){                     # should set a lower thereshold for num of module common genes, more than 50%
    module_labels[module_common_genes]=1
    if(length(addi_args)==0){
      cvfit=glmnet(gene_pathway_matrix,module_labels,lambda = lambda,alpha =alpha,...) 
    }else{
      cvfit=glmnet(gene_pathway_matrix,module_labels,alpha =alpha,...) 
    }
    coef=coef(cvfit, s = "lambda.min")
    non0index=coef@i[-1]   #remove intercept
    non0coef=coef@x[-1]
    selected_index=non0index[which(non0coef>0)]
    selected_pathways=all_pathways[selected_index]
    selected_coef=non0coef[which(non0coef>0)]
    names(selected_coef)=selected_pathways
    
    if(length(selected_pathways)>0){
      fisher_exact_test_results=fisher_exact_test(selected_pathways,module_common_genes,gene_pathway_matrix="default" )
      selected_pathways_fisher_pvalue=fisher_exact_test_results$selected_pathways_fisher_pvalue
      selected_pathways_num_genes=fisher_exact_test_results$selected_pathways_num_genes
      
      new_order=order(selected_coef,decreasing = TRUE)
      
      return(list(selected_pathways_names=from_id2name(selected_pathways=names(selected_coef[new_order])),
                  selected_pathways_coef=selected_coef[new_order],
                  selected_pathways_fisher_pvalue=selected_pathways_fisher_pvalue[new_order],
                  selected_pathways_num_genes=selected_pathways_num_genes[new_order]
                  ))
    }else{
      return(NULL)}
  }
  
}

