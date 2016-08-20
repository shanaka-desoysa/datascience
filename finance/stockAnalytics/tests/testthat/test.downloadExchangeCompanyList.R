context("downloadExchangeCompanyList")

test_that("downloadExchangeCompanyList: Data folder was  created.", {
    # Unit Test 1: Check if data folder was  created.
    # Initialize
    exchange = "NASDAQ"
    dataFolder = "./datatest"

    # Delete data folder.
    if (file.exists(dataFolder)) {
        unlink(dataFolder, recursive = T)
    }

    downloadExchangeCompanyList(exchange, dataFolder)

    expect_true(file.exists(dataFolder), "Unit Test 1: DataFolder was not creaed.")

    # Cleanup
    if (file.exists(dataFolder)) {
        unlink(dataFolder, recursive = T, force = T)
    }
})

test_that("downloadExchangeCompanyList: Single output file.", {
    # Initialize
    exchange = "NASDAQ"
    dataFolder = "./datatest"

    actual <- unlist(downloadExchangeCompanyList(exchange, dataFolder))
    expected <- paste(dataFolder, "/", exchange, "-companylist", ".csv", sep = "")
    #printActualExpected(actual, expected)
    expect_equal(actual, expected, info = "File name is not in correct format.")
    expect_true(file.exists(expected), info = "File does not exist.")
    csvFile <- read.csv(expected)
    expect_true("Symbol" %in% colnames(csvFile), info = "Column Symbol does not exist")
    expect_true("Name" %in% colnames(csvFile), info = "Column Name does not exist")

    # Cleanup
    if (file.exists(dataFolder)) {
        unlink(dataFolder, recursive = T, force = T)
    }
})

test_that("downloadExchangeCompanyList: Multiple output files.", {
    # Initialize
    exchanges = c("NASDAQ", "NYSE")
    dataFolder = "./datatest"

    lapply(exchanges, function(exchange) {
        actual <- unlist(downloadExchangeCompanyList(exchange, dataFolder))
        expected <- paste(dataFolder, "/", exchange, "-companylist", ".csv", sep = "")
        #printActualExpected(actual, expected)
        expect_equal(actual, expected, info = "File name is not in correct format.")
        expect_true(file.exists(expected), info = "File does not exist.")
        csvFile <- read.csv(expected)
        expect_true("Symbol" %in% colnames(csvFile), info = "Column Symbol does not exist")
        expect_true("Name" %in% colnames(csvFile), info = "Column Name does not exist")
    })

    # Cleanup
    if (file.exists(dataFolder)) {
        unlink(dataFolder, recursive = T, force = T)
    }
})