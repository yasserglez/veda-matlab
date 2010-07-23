gofCopulaWrapper <- function(copulaName, data) {
    result <- tryCatch(gofCopulaInternal(copulaName, data), error = function(error) NULL)
    if (is.null(result)) {
        # Return a value that will make the algorithm ignore this copula.
        result <- list(statistic=.Machine$double.xmax, pvalue=0, parameters=0)
    }
    result
}

gofCopulaInternal <- function(copulaName, data) {
    copula <- {
        if (copulaName == "frank") {
            frankCopula(1)
        }
        else if (copulaName == "clayton") {
            claytonCopula(1)
        }
        else if (copulaName == "gaussian") {
            normalCopula(0)
        }        
        else if (copulaName == "t") {
            tcopula <- tCopula(0)
            fit <- fitCopula(tcopula, data, method="ml", start=tcopula@parameters)
            rho <- fit@copula@parameters[1]
            df <- fit@copula@parameters[2]
            tCopula(rho, df=df, df.fixed=TRUE)
        }
    }
    result <- gofCopula(copula, data, method="itau", simulation="mult")
    if (copulaName == "t") {
        result$parameters <- c(result$parameters, copula@df)
    }
    result
}
