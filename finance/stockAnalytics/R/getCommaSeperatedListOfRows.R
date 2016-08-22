#' Title
#'
#' @param csvFile
#' @param colName
#' @param take
#'
#' @return
#' @export
#'
#' @examples
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
