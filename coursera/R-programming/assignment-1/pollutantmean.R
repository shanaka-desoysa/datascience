pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate"

    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used

    ## Return the mean of the pollutant across all monitors list
    ## in the ' id' vector (ignoring NA values)
    ## NOTE: Do not round the result!

    ##sprintf("Directory: %s,  Pollutant: %s", directory, pollutant)

    pollutants <- c("sulfate", "nitrate")
    if (!is.element(pollutant, pollutants)) {
        stop("Unidentified pollutant.")
    }

    i <- 1
    alldata <- numeric()
    for (mid in id) {
        filepath <- sprintf("%s/%03d.csv", directory, mid)
        csvdata <- read.csv(filepath)
        alldata <- c(alldata, csvdata[[pollutant]])
        i <- i + 1
    }
    output <- mean(alldata, na.rm = TRUE)
    output
}

# complete <- function(directory, id = 1:332) {
#     ## 'directory' is a character vector of length 1 indicating
#     ## the location of the CSV files
#
#     ## 'id' is an integer vector indicating the monitor ID numbers
#     ## to be used
#
#     ## Return a data frame of the form:
#     ## id nobs
#     ## 1 117
#     ## 2 1041
#     ## ...
#     ## where ' id' is the monitor ID number and 'nobs' is the number of complete cases
#
#     i <- 1
#     alldata <- data.frame(id = integer(), nobs = integer())
#     for (mid in id) {
#         filepath <- sprintf("%s/%03d.csv", directory, mid)
#         ##print(x)
#         csvdata <- read.csv(filepath)
#         ## Another way csvdata[complete.cases(csvdata),]
#         alldata[i,] <-c(mid, nrow(na.omit(csvdata)))
#         i <- i + 1
#     }
#     alldata
# }

