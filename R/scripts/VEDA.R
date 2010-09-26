library(vines)

copulaObject <- function (copulaName) {
    copulaName <- tolower(copulaName)
    if (copulaName %in% c("normal", "gaussian")) {
        copula <- normalCopula(0)
    }
    return(copula)
}

learnVine <- function (type, data, trees, corTestSigLevel, ...) {
    copulas <- lapply(..., copulaObject)
    fit <- fitVine(type, data, trees = trees, corTestMethod = "kendall", 
        corTestSigLevel = corTestSigLevel, gofCopulaIters = 500, 
        gofCopulaMethod = "itau", gofCopulaSimul = "mult", 
        copulas = copulas)
    VINE <<- fit@vine
    # TODO: Return an string with information about the fitted vine.
    return("")
}

sampleVine <- function (n) {
    u <- rvine(VINE, n)
    return(u)
}

