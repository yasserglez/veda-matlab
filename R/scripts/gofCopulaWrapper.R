gofCopulaWrapper <- function(copula, data) {
    copula <- switch(copula,
                     frank=frankCopula(0),
                     gaussian=normalCopula(0))
    answer <- tryCatch(gofCopula(copula, data, method="itau", simulation="mult"),
                       error=function(error) NULL)
    if (is.null(answer)) {
        # Return a value that will make the algorithm ignore this copula.
        answer <- list(statistic=.Machine$double.xmax, pvalue=0, parameters=0)
    }
    answer
}
