rankhospital <-
    function(state,
             outcome,
             num = "best",
             debug = FALSE) {
        ## Read outcome data
        outcome_data <-
            read.csv("outcome-of-care-measures.csv", colClasses = "character")

        ## Check that state and outcome are valid
        if (!is.element(state, outcome_data[, 7])) {
            stop("invalid state")
        }

        if (!is.element(outcome, c("heart attack", "heart failure", "pneumonia"))) {
            stop("invalid outcome")
        }

        ## Return hospital name in that state with the given rank
        ## 30-day death rate

        outcome_data = outcome_data[outcome_data$State == state,]

        if (is.numeric(num) & num > length(outcome_data)) {
            return(NA)
        }

        if (outcome == "heart attack") {
            outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <-
                as.numeric(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
            outcome_data <-
                outcome_data[!is.na(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),]

            outcome_data <-
                outcome_data[order(
                    outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
                    outcome_data$Hospital.Name
                ), ]

            if (debug) {
                print(outcome_data)
            }
        }
        else if (outcome == "pneumonia") {
            outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <-
                as.numeric(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
            outcome_data <-
                outcome_data[!is.na(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia),]
            outcome_data <-
                outcome_data[order(
                    outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,
                    outcome_data$Hospital.Name
                ), ]

            if (debug) {
                print(outcome_data)
            }
        }
        else if (outcome == "heart failure") {
            outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <-
                as.numeric(
                    outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
                )
            outcome_data <-
                outcome_data[!is.na(
                    outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
                ),]
            outcome_data <-
                outcome_data[order(
                    outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
                    outcome_data$Hospital.Name
                ),]

            if (debug) {
                print(outcome_data)
            }
        }

        outcome_data$Rank <- seq.int(nrow((outcome_data)))
        ##outcome_data <- outcome_data[, "Hospital.Name"]

        if (num == "best") {
            return(outcome_data[outcome_data$Rank == 1, "Hospital.Name"])
        }
        else if (num == "worst") {
            return(outcome_data[outcome_data$Rank == max(outcome_data$Rank), "Hospital.Name"])
        }
        else if (is.numeric(num)) {
            return(outcome_data[outcome_data$Rank == num, "Hospital.Name"])
        }
        # return(outcome_data)
    }

testRankhospital <- function(debug = FALSE) {

}
