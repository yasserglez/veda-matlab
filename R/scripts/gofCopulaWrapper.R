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
            c <- claytonCopula(1)
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
    else if (copulaName == "clayton") {
        # Lower bound of the parameters set to -1 for the bivariate Clayton copula
        # wich differs with the Appendix B.3 of Aas, K., Czado, C., Frigessi, A. & Bakken,
        # H. Pair-copula constructions of multiple dependence Norwegian Computing Center, 
        # NR, 2006 (SAMBA/24/06).
        result$parameters <- max(result$parameters, 0)
    }
    result
}
