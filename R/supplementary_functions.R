#' Helper function to load file
#' @param objName Object name to be loaded
#' @param package Package name to be loaded
#' @return The object
#' This function is temporarily set up to help the transition from .rds to .RData file
#' @importFrom utils data
mydata <- function(objName, package) {
    nv <- new.env()
    data(list=c(objName), package=package, envir = nv)
    return(get(objName, envir = nv))
}

#' fisher_exact_test
#'
#' This function allows you to compute two sided fish exact pvalue of gene list for selected  pathways
#' To know more about this method. I recommend you to read the paper (Enrichment or depletion of a GO category within a class of genes: which test?) for more details
#' @param selected_pathways A vecor of pathways to be used for enrichment analysis for genes in \emph{gene_input}.It should have same ID types(E.g. pathway ID, pathway names) as the pathways in \emph{gene_pathway_matrix}.
#' @param gene_input A vecor of genes to be annotated. It should have same ID types(E.g. Ensembl ID, HUGO gene symbol) as the genes in \emph{gene_pathway_matrix}.
#' @param gene_pathway_matrix A binary background matrix whose columns are the pathways/gene sets and
#'whose rows are all the genes from pathways/gene sets . It could be in sparse matrix format ((inherit from class "sparseMatrix" as in package Matrix) to save memory.
#'For gene i and pathway j, the value of matrix(i,j) is 1 is gene i belonging to pathway j otherwise 0.
#'Users could leave it as default value then  it will use pre-collected gene_pathway_matrix from GO Ontology and REACTOME databaase.
#'Otherwise, they could use their own customized gene_pathway_matrix
#' @return  A list of two elements:
#' \itemize{
#'   \item selected_pathways_fisher_pvalue - Fisher exact pvalue for selected pathways
#'   \item selected_pathways_num_genes - The number of genes for selected pathways in background
#' }
#' @export
#' @examples
#' fetRes <- fisher_exact_test(selected_pathways=c("GO:0007250","GO:0008625"),
#'   gene_input=c("TRPC4AP","CDC37","TNIP1","IKBKB","NKIRAS2","NFKBIA","TIMM50",
#'      "RELB","TNFAIP3","NFKBIB","HSPA1A","NFKBIE","SPAG9","NFKB2","ERLIN1",
#'      "REL","TNIP2","TUBB6","MAP3K8"),gene_pathway_matrix=NULL)
fisher_exact_test=function(selected_pathways,gene_input,gene_pathway_matrix=NULL){
  if(is.null(gene_pathway_matrix)){
    gene_pathway_matrix=mydata("gene_pathway_matrix", package="GENEMABR")
  }
  all_genes=rownames(gene_pathway_matrix)
  module1_common_genes=intersect(all_genes,gene_input)

  selected_pathways_fisher_pvalue=vector()
  selected_pathways_num_genes=vector()
  for(index in seq_len(length(selected_pathways))){
    fisher_pathway=selected_pathways[index]
    #          genes_in_common      genes_in_reference
    #pathway          a                   c
    #no_pathway       b                   d
    a=sum(gene_pathway_matrix[module1_common_genes,fisher_pathway])
    b=length(module1_common_genes)-a
    c=sum(gene_pathway_matrix[,fisher_pathway])-a
    d=length(all_genes)-a-c-b
    contigency_table=matrix(c(a,b,c,d),nrow = 2)
    fisher_result=stats::fisher.test(contigency_table)
    selected_pathways_fisher_pvalue[fisher_pathway]=fisher_result[['p.value']]
    selected_pathways_num_genes[fisher_pathway]=sum(gene_pathway_matrix[,fisher_pathway])
  }
  return(list(selected_pathways_fisher_pvalue=selected_pathways_fisher_pvalue,selected_pathways_num_genes=selected_pathways_num_genes))
}



#' find_root_ids
#'
#' If you use the default pathway databases(GO Ontologyand REACTOME),this function allows you to extract GO sub-roots or REACTOME roots for certain pathways from GO or REACTOME
#' to help you better understanding thier the biological meanings
#' @param selected_pathways A vecor of GO and/or REACTOME pathways IDs.
#' @return  A list of GO sub-root or REACTOME root ids for provided pathways.
#' If a certain pathway has morn than one GO sub-roots or REACTOME roots, they will be seperated by "#".
#' @importFrom igraph ego gorder
#' @export
#' @examples
#' find_root_ids(selected_pathways=c("GO:0005834","R-HSA-111469"))
find_root_ids=function(selected_pathways){
  go_ontology=mydata("human_go_ontology", package="GENEMABR")
  go_sub_roots=mydata("human_go_sub_roots", package="GENEMABR")
  go_sub_roots=unlist(go_sub_roots)
  reactome_ontology=mydata("human_reactome_ontology", package="GENEMABR")
  reactome_roots=mydata("human_reactome_roots", package="GENEMABR")

  find_roots=lapply(selected_pathways, function(x){
    if(grepl("GO",x)){
      parent_nodes=ego(go_ontology,order = gorder(go_ontology),x,mode = "in")
      find_roots=intersect(go_sub_roots,names(unlist(parent_nodes)))
    }else{
      parent_nodes=ego(reactome_ontology,order = gorder(reactome_ontology),x,mode = "in")
      find_roots= intersect(reactome_roots,names(unlist(parent_nodes)))
    }
    if(length(find_roots)>1){
      find_roots=paste0(unlist(find_roots),collapse = "#")
    }
    return(find_roots)
  })
  names(find_roots)=selected_pathways
  return(find_roots)

}


#' from_id2name
#'
#' If you use the default pathway databases(GO Ontologyand REACTOME),this function can help you to get pathways names from pathways IDs.
#' @param selected_pathways A list of GO and/or REACTOME pathways IDs. Each elmment is this list can be a single id or multi-ids seperated "#"
#' @return  A list of GO sub-root or REACTOME root names for provided pathways.
#' @importFrom igraph V as_ids
#' @export
#' @examples
#' from_id2name((selected_pathways=list(c("GO:0032991#GO:0044425#GO:0044464"),"R-HSA-5357801")))
from_id2name=function(selected_pathways){
  go_ontology=mydata("human_go_ontology", package="GENEMABR")
  reactome_ontology=mydata("human_reactome_ontology", package="GENEMABR")

  go_ontology_names=V(go_ontology)$pathway_names
  names(go_ontology_names)=as_ids(V(go_ontology))
  reactome_ontology_names=V(reactome_ontology)$pathway_names
  names(reactome_ontology_names)=as_ids(V(reactome_ontology))

  names=lapply(selected_pathways, function(x){
    if(grepl("#",x)){
      if(grepl("GO",x)){
        y=strsplit(x,split = "#")[[1]]
        unname(go_ontology_names[y])
      }else{
        y=strsplit(x,split = "#")[[1]]
        unname(reactome_ontology_names[y])
      }
    }else{
      if(grepl("GO",x)){
        unname(go_ontology_names[x])
      }else{
        unname(reactome_ontology_names[x])
      }
    }
  })
  names(names)=selected_pathways
  return(names)
}

#' get_steps
#'
#' If you use the default pathway databases(GO Ontologyand REACTOME),this function allows you to extract  the distances from ceatain pathways to  GO roots or REACTOME roots nodes.
#' @param selected_pathways A vecor of GO and/or REACTOME pathways IDs.
#' @return  A list contains distances from pathways to GO root or REACTOME root nodes
#' @importFrom igraph distances
#' @export
#' @examples
#' get_steps(selected_pathways=c("GO:0005834","R-HSA-111469"))
get_steps=function(selected_pathways){
  go_ontology=mydata("human_go_ontology", package="GENEMABR")
  go_roots=mydata("human_go_roots", package = "GENEMABR")
  go_roots=unlist(go_roots)
  reactome_ontology=mydata("human_reactome_ontology", package="GENEMABR")
  reactome_roots=mydata("human_reactome_roots", package="GENEMABR")

  steps=lapply(selected_pathways,function(x){
    if(grepl("GO",x)){
      min(distances(go_ontology,v=go_roots,to=x))
    }else{
      min(distances(reactome_ontology,v=reactome_roots,to=x))
    }
  })
  names(steps)=selected_pathways
  return(steps)
}

