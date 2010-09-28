library(vines)

copulaObject <- function (copulaName) {
    copulaName <- tolower(copulaName)
    if (copulaName %in% c("normal", "gaussian")) {
        normalCopula(0)
    } else if (copulaName == "t") {
      tCopula(0)
    } else if (copulaName == "clayton") {
      claytonCopula(1)
    } else if (copulaName == "gumbel") {
      gumbelCopula(1)
    } 
}

learnVine <- function (type, data, trees, corTestSigLevel, ...) {
    copulas <- lapply(..., copulaObject)
    fit <- fitVine(type, data, trees = trees, 
        corTestSigLevel = corTestSigLevel, 
        gofCopulaMethod = "itau", gofCopulaSimul = "mult",
        optimMethod = NULL, copulas = copulas)
    VINE <<- fit@vine

    return("")
}

sampleVine <- function (n) {
    u <- rvine(VINE, n)

    return(u)
}
