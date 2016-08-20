#' Download Company Lists From Exchanges
#'
#' Download Company Lists From Financial Exchanges such as NASDAQ, NYSE, AMEX.
#' Save the Company List in csv format.
#' @param exchanges Name of the Exchange(s). Supported: NASDAQ, NYSE, AMEX.
#' @param dataFolder Folder the Company List will be saved.
#' @param fileNameAppend Append file name. Default "companylist".
#'
#' @return Exported Filenames.
#' @export
#'
#' @examples
#' downloadExchangeCompanyList("NASDAQ", "./data", "companylist") => Downloads NASDAQ Companies to ./data/nasdaq-companylist.csv.
#' downloadExchangeCompanyList(c("NYSE, AMEX"), "./company", "list") => Downloads NYSE and AMEX Companies to ./company/nasdaq-list.csv and ./company/nasdaq-list.csv.
downloadExchangeCompanyList <-
function(exchanges, dataFolder, fileNameAppend = "companylist") {
    dataFileUrl <- "http://www.nasdaq.com/screening/companies-by-name.aspx?letter=0&exchange=EXCNAME&render=download"
    dataFile <- paste(dataFolder, "/EXCNAME-", fileNameAppend, ".csv", sep = "")

    # Create data folder if doesn't exist.
    if (!file.exists(dataFolder)) {
        dir.create(dataFolder)
    }

    # Initialize output vector
    fileNames <- vector()

    fileNames <- lapply(exchanges, function(x) {
        # Set data file name and URL
        dataFileUrl <- sub("EXCNAME", x, dataFileUrl)
        dataFile <- sub("EXCNAME", x, dataFile)

        # print(dataFileUrl)
        if (!file.exists(dataFile)) {
            download.file(dataFileUrl, destfile = dataFile)
        }

        # Output filename
        dataFile
    })

    # Output vector
    fileNames
}
