#' Print Actual and Expected
#'
#' @param actual Actual value.
#' @param expected Expected value.
#' @param msg Prepend message.
#'
#' @return Message.
#' @export
#'
#' @examples printActualExpected("Test", 5, 10)
printActualExpected <-
function(actual, expected, msg = "") {
    message(paste(msg, " Actual:", actual, "  Expected: ", expected, sep = ""))
}
