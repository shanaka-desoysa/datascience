#' Title
#'
#' @param csvFile CSV file to read.
#' @param colName Column name of the CSV file. Default "Symbol".
#' @param take How many records to take at a time. Default 5.
#'
#' @return Data frame with comma seperated rows.
#' @export 
#'
#' @examples getCommaSeperatedListOfRows("data1/NASDAQ-companylist.csv")
getCommaSeperatedListOfRows <- function(csvFile, colName = "Symbol", take = as.integer(5)) {
    if (!is.numeric(take)) {
        stop("Parameter take must be an integer.")
    }
    csvOut <- read.csv(csvFile)
    csvOut <- trimws(csvOut[, colName])

    #  Split by number of items to take
    records <- length(csvOut)
    message(paste("Total number of symbols: ", records))

    loIdx <- 1
    hiIdx <- loIdx + take - 1

    output <- vector()
    while (hiIdx <= records) {
        # print(paste("Concat From", loIdx, hiIdx))
        concat <- csvOut[loIdx:hiIdx]
        concat <- paste(concat, collapse = ",")
        output <- c(output, concat)
        loIdx <- (loIdx + take)
        hiIdx <- loIdx + take - 1
        if ((loIdx <= records) & (hiIdx > records)) {
            hiIdx <- records
        }
    }
    output
}
