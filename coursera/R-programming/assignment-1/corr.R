corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0

    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!

    comp <- complete(directory)
    count <- nrow(comp)
    cordata <- numeric(0)

    for (mid in 1:count) {
        if (comp[mid, ]$nobs > threshold) {
            filepath <- sprintf("%s/%03d.csv", directory, mid)
            csvdata <- read.csv(filepath)
            cordata <-
                c(
                    cordata,
                    cor(csvdata$sulfate, csvdata$nitrate, use = "pairwise.complete.obs")
                )
        }
    }
    return(cordata)
}
