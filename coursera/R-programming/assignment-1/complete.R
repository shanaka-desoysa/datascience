complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used

    ## Return a data frame of the form:
    ## id nobs
    ## 1 117
    ## 2 1041
    ## ...
    ## where ' id' is the monitor ID number and 'nobs' is the number of complete cases

    i <- 1
    alldata <- data.frame(id = integer(), nobs = integer())
    for (mid in id) {
        filepath <- sprintf("%s/%03d.csv", directory, mid)
        ##print(x)
        csvdata <- read.csv(filepath)
        ## Another way csvdata[complete.cases(csvdata),]
        alldata[i,] <-c(mid, nrow(na.omit(csvdata)))
        i <- i + 1
    }
    alldata
}

