library(gerr)
library(glmnet)
library(Matrix)

test_that("Test regression_selected_pathways", {

    # selected_pathways_names=list("RIP-mediated NFkB activation via ZBP1","IkBA variant leads to EDA-ID",
    #                              "negative regulation of interferon-beta production","TRAF6 mediated NF-kB activation",
    #                              "I-kappaB kinase/NF-kappaB signaling","ZBP1(DAI) mediated induction of type I IFNs")
    # names(selected_pathways_names)=c("R-HSA-1810476","R-HSA-5603029","GO:0032688","R-HSA-933542","GO:0007249","R-HSA-1606322")
    #
    # selected_pathways_coef=c(0.12593491,0.07105989,0.01993546,0.01910265,0.00513055, 0.00219621 )
    # names(selected_pathways_coef)=c("R-HSA-1810476","R-HSA-5603029","GO:0032688","R-HSA-933542","GO:0007249","R-HSA-1606322")
    #
    # selected_pathways_fisher_pvalue=c(3.511133e-10,4.005332e-08,6.338554e-05,1.929685e-09,4.985802e-11,7.596824e-10)
    # names(selected_pathways_fisher_pvalue)=c("R-HSA-1810476","R-HSA-5603029","GO:0032688","R-HSA-933542","GO:0007249","R-HSA-1606322")
    #
    # selected_pathways_num_genes=c( 11,7,11,16 ,63,13)
    # names(selected_pathways_num_genes)=c("R-HSA-1810476","R-HSA-5603029","GO:0032688","R-HSA-933542","GO:0007249","R-HSA-1606322")
    #
    # a=list(selected_pathways_names=selected_pathways_names,selected_pathways_coef=selected_pathways_coef,
    #        selected_pathways_fisher_pvalue=selected_pathways_fisher_pvalue,selected_pathways_num_genes=selected_pathways_num_genes)
    #
    # expect_equal(regression_selected_pathways(gene_input = c("TRPC4AP","CDC37","TNIP1","IKBKB","NKIRAS2","NFKBIA","TIMM50","RELB",
    #                                                          "TNFAIP3","NFKBIB","HSPA1A","NFKBIE","SPAG9",
    #                                                          "NFKB2","ERLIN1","REL","TNIP2","TUBB6","MAP3K8"),alpha = 0.5), a)

    expect_equal(regression_selected_pathways(gene_input = c("TRPC4AP","CDC37","TNIP1"),alpha = 1), NULL)
})
