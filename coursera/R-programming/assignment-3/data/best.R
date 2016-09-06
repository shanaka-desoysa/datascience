best <- function(state, outcome, debug = FALSE) {
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

    ## Return hospital name in that state with lowest 30-day death
    ## rate
    result <- character(0)
    outcome_data = outcome_data[outcome_data$State == state, ]

    if (outcome == "heart attack") {
        outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <-
            as.numeric(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
        outcome_data <-
            outcome_data[!is.na(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), ]
        min_val <-
            min(
                outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
                na.rm = TRUE
            )
        if (debug) {
            print(min_val)
        }
        result <-
            with(outcome_data, Hospital.Name[Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == min_val])
    }
    else if (outcome == "pneumonia") {
        outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <-
            as.numeric(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
        outcome_data <-
            outcome_data[!is.na(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), ]
        min_val <-
            min(
                outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,
                na.rm = TRUE
            )
        if (debug) {
            print(min_val)
        }
        result <-
            with(outcome_data, Hospital.Name[Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == min_val])
    }
    else if (outcome == "heart failure") {
        outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <-
            as.numeric(
                outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
            )
        outcome_data <-
            outcome_data[!is.na(
                outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
            ), ]
        min_val <-
            min(
                outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
                na.rm = TRUE
            )
        if (debug) {
            print(min_val)
        }
        result <-
            with(outcome_data, Hospital.Name[Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == min_val])
    }

    return(head(sort(result), 1))
}


testBest <- function(debug = FALSE) {
    print(best("TX", "heart attack"))
    print(best("TX", "heart failure"))
    print(best("MD", "heart attack"))
    print(best("MD", "pneumonia"))
    print(best("BB", "heart attack"))
    print(best("NY", "hert attack"))
}
