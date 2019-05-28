library(gerr)
library(igraph)
library(Matrix)


test_that("Test find_root_ids", {
    a=list()
    a[[1]]="R-HSA-168256"
    names(a)="R-HSA-1810476"

    b=list()
    b[[1]]="GO:0065007"
    names(b)="GO:0032688"

    expect_equal(find_root_ids("R-HSA-1810476"), a)
    expect_equal(find_root_ids("GO:0032688"), b)
})


test_that("Test from_id2name", {
    a=list()
    a[[1]]="R-HSA-168256"
    names(a)="R-HSA-1810476"

    b=list()
    b[[1]]="GO:0009987#GO:0065007"
    names(b)="GO:0007249"


    test_a=list()
    test_a[[1]]="Immune System"
    names(test_a)="R-HSA-168256"

    test_b=list()
    test_b[[1]]=c("cellular process", "biological regulation")
    names(test_b)="GO:0009987#GO:0065007"

    expect_equal(from_id2name(a), test_a)
    expect_equal(from_id2name(b), test_b)
})


test_that("Test get_steps", {
    a=list(3,4)
    names(a)=c("GO:0005834","R-HSA-111469")
    expect_equal(get_steps(c("GO:0005834","R-HSA-111469")), a)

})
