if (!require("RJSONIO")) {
    install.packages("RJSONIO")
}
library("RJSONIO")

if (!require("plyr")) {
    install.packages("plyr")
}
library("plyr")

#' Download stock data from Google Finance
#'
#' @param symbols Comma seperated list of symbols in EXCHANGE:SYMBOL format.
#'
#' @return A data frame with stock data
#' @export
#'
#' @examples downloadStockData("NASDAQ:PIH,NASDAQ:FLWS,NASDAQ:FCCY")
downloadStockData <- function(symbols, dataFolderFormat = "./data/%Y%m%d", fileNameFromat = "/%H%M%S%OS.csv") {
    # http://www.google.com/finance/info?infotype=infoquoteall&q=NASDAQ:AAPL
    # http://finance.google.com/finance/info?client=ig&q=AAPL
    # http://www.google.com/finance/info?q=NASDAQ:PIH,NASDAQ:FLWS,NASDAQ:FCCY

    directory <- format(Sys.time(), dataFolderFormat)

    if (!file.exists(directory)) {
        dir.create(directory, recursive = T)
    }

    quotes <- readLines(paste('http://www.google.com/finance/info?q=', symbols, sep = ""))
    quotes <- quotes[2:length(quotes)]
    quotes[1] <- '['
    quotes <- paste(quotes, collapse = '')
    json_file <- fromJSON(quotes)

    json_file <- ldply(json_file, function(x) t(x[]))

     directory <- paste("./data/", format(Sys.time(), "%Y%m%d"), sep = "")
    
     if (!file.exists(directory)) {
         dir.create(paste("./data/", format(Sys.time(), "%Y%m%d/"), sep = ""))
     }
    
    write.csv(json_file, file = paste(directory, format(Sys.time(), fileNameFromat), sep = ""), row.names = F)
}

downloadStockData("SPX,SHY,NASDAQ:AAPL,NASDAQ:GOOGL,NASDAQ:MSFT")

#downloadStockData("SPX,SHY,VFINX,PRPFX,FBALX,NASDAQ:AAPL,NASDAQ:GOOGL,NASDAQ:MSFT,NASDAQ:FCCY")
