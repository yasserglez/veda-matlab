gofCopulaWrapper <- function(copula, data) {
    c <- switch(copula, 
                frank=frankCopula(1),
                gaussian=normalCopula(0))
    gofCopula(c, data, method="itau", simulation="mult")
}
