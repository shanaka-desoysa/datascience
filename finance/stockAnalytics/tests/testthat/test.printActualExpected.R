context("printActualExpected")

test_that("printActualExpected: ", {
    # Initialize
    actual <- "actual 123"
    expected <- "expected 456"
    msg <- "message"
    expect_message(printActualExpected(actual, expected, msg), paste(msg, " Actual:", actual, "  Expected: ", expected, sep = ""))

    # Cleanup

})