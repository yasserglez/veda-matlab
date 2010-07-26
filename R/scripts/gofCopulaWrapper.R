gofCopulaWrapper <- function(copulaName, data) {
    result <- tryCatch(gofCopulaInternal(copulaName, data), error=function(error) NULL)
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
        else if (copulaName == "gumbel") {
            gumbelCopula(1)
        }        
        else if (copulaName == "gaussian") {
            normalCopula(0)
        }
        else if (copulaName == "t") {
            # The gofCopula method requires the degrees-of-freedom parameter to be fixed.
            # Therefore, we estimate a value for this parameters before creating the 
            # copula object.
            c <- tCopula(0)
            fit <- fitCopula(c, data, method="ml", start=c@parameters)
            rho <- fit@copula@parameters[1]
            df <- fit@copula@parameters[2]
            tCopula(rho, df=df, df.fixed=TRUE)
        }
    }
    result <- gofCopula(copula, data, method="itau", simulation="mult")
    if (copulaName == "t") {
        # As the degrees-of-freedom is fixed it is not included in the parameters.
        result$parameters <- c(result$parameters, copula@df)
    }
    result
}
