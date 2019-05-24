#' regression_selected_pathways
#'
#' This function allows you to extracte enriched pathways for gene module/list via regressioin (elastic net)
#' based method
#' @param gene_input A vecor of genes to be annotated. It should have same ID types(Ensembl ID, HUGO gene symbol)
#' as the genes in \emph{gene_pathway_matrix}.
#' @param gene_pathway_matrix A binary background matrix whose columns are the pathways/gene sets and
#'whose rows are all the genes from pathways/gene sets . It could be in sparse matrix format ((inherit from class
#' "sparseMatrix" as in package Matrix) to save memory.
#'For gene i and pathway j, the value of matrix(i,j) is 1 is gene i belonging to pathway j otherwise 0.
#'Users could leave it as default value then  it will use pre-collected gene_pathway_matrix from GO Ontology and
#'REACTOME databaase.
#'Otherwise, they could use their own customized gene_pathway_matrix
#' @param alpha The elasticnet mixing parameter, with \eqn{0~\leq~\alpha~\leq~1}. The penalty is defined as
#'\eqn{(1-\alpha)/2||\beta||_2^2+\alpha||\beta||_1}.
#'alpha=1 is the lasso penalty, and alpha=0 the ridge penalty. Default value: 0.5.
#' @param family Response type, currently \code{gaussian} and \code{binomial} are supported. Future extensions are likely.
#' @param lambda A user supplied lambda sequence, see \code{\link{glmnet}} and use with care.
#' @param ... Other paramaters for glmnet function.
#' @return  A list of following elements:
#' \itemize{
#'   \item selected_pathways_names - Pathways names for selected pathways
#'   \item selected_pathways_coef - Regression coefficients value for selected pathways
#'   \item selected_pathways_fisher_pvalue - Fisher exact pvalue for selected pathways
#'   \item selected_pathways_num_genes - The number of genes for selected pathways in background
#'   \item model - the trained glmnet model
#' }
#' @importFrom glmnet glmnet cv.glmnet
#' @export
#' @examples
#' rspResults <- regression_selected_pathways(gene_input=c("TRPC4AP","CDC37",
#'   "TNIP1","IKBKB","NKIRAS2", "NFKBIA","TIMM50","RELB","TNFAIP3","NFKBIB",
#'   "HSPA1A","NFKBIE","SPAG9","NFKB2","ERLIN1","REL","TNIP2",
#'   "TUBB6","MAP3K8"),
#'  gene_pathway_matrix=NULL,lambda=NULL,alpha=0.5)
regression_selected_pathways=function(gene_input,gene_pathway_matrix=NULL,alpha=0.5,
                                      family=c("gaussian", "binomial"), lambda=NULL,
                                      ...){
  family <- match.arg(family)
  if(is.null(gene_pathway_matrix)){
    gene_pathway_matrix <- mydata("gene_pathway_matrix", "GENEMABR")
  }

  all_genes=rownames(gene_pathway_matrix)
  all_pathways=colnames(gene_pathway_matrix)
  
  module_labels=rep(0,length(all_genes))
  names(module_labels)=all_genes
  module_common_genes=intersect(all_genes,gene_input)

  if(length(module_common_genes)<=1) {
    warning("Not enough genes in the set of genes of interest. NULL is returned")
    return(NULL)
  }
  
  module_labels[module_common_genes]=1
  if(family=="binomial"){
    module_labels = factor(module_labels)
    lambda <- NULL
  } else if (family=="gaussian" && is.null(lambda)) {
    lambda <- c(0.007956622,0.01)
  }
  
  cvfit=cv.glmnet(gene_pathway_matrix,module_labels,alpha =alpha, 
                  family=family, lambda=lambda, ...)
  
  coef=coef(cvfit, s = "lambda.min")
  non0index=coef@i[-1]   #remove intercept
  non0coef=coef@x[-1]
  selected_index=non0index[which(non0coef>0)]
  selected_pathways=all_pathways[selected_index]
  selected_coef=non0coef[which(non0coef>0)]
  names(selected_coef)=selected_pathways
  
  if(length(selected_pathways)>0){
    fisher_exact_test_results=fisher_exact_test(selected_pathways,module_common_genes,gene_pathway_matrix=NULL )
    selected_pathways_fisher_pvalue=fisher_exact_test_results$selected_pathways_fisher_pvalue
    selected_pathways_num_genes=fisher_exact_test_results$selected_pathways_num_genes
    
    new_order=order(selected_coef,decreasing = TRUE)
    
    res <- list(selected_pathways_names=from_id2name(selected_pathways=names(selected_coef[new_order])),
                selected_pathways_coef=selected_coef[new_order],
                selected_pathways_fisher_pvalue=selected_pathways_fisher_pvalue[new_order],
                selected_pathways_num_genes=selected_pathways_num_genes[new_order],
                model=cvfit)
    return(res)
  } else {
    warning("No selected gene-sets with the given parameter set. NULL is returned.")
    return(NULL)
  }
}


