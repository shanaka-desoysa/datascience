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

test_that("downloadExchangeCompanyList: Single output file name.", {
    # Initialize
    exchange = "NASDAQ"
    dataFolder = "./datatest"

    actual <- unlist(downloadExchangeCompanyList(exchange, dataFolder))
    expected <- paste(dataFolder, "/", exchange, "-companylist", ".csv", sep = "")
    printActualExpected(actual, expected)
    expect_equal(actual, expected, msg = "File name is not in correct format.")

    # Cleanup
    if (file.exists(dataFolder)) {
        unlink(dataFolder, recursive = T, force = T)
    }
})

test_that("downloadExchangeCompanyList: Multiple output file names.", {
    # Initialize
    exchange = c("NASDAQ", "NYSE")
    dataFolder = "./datatest"

    actual <- unlist(downloadExchangeCompanyList(exchange, dataFolder))
    expected <- unlist(paste(dataFolder, "/", exchange, "-companylist", ".csv", sep = ""))
    printActualExpected(actual, expected)
    expect_equal(actual, expected, msg = "File name is not in correct format.")

    # Cleanup
    if (file.exists(dataFolder)) {
        unlink(dataFolder, recursive = T, force = T)
    }
})