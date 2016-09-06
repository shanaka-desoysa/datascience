rankall <-
    function(outcome,
             num = "best",
             debug = FALSE) {
        ## Read outcome data
        outcome_data <-
            read.csv("outcome-of-care-measures.csv", colClasses = "character")

        ## Check that num and outcome are valid
        if (!is.element(outcome, c("heart attack", "heart failure", "pneumonia"))) {
            stop("invalid outcome")
        }
        if (is.numeric(num)) {
            if (num > length(outcome_data)) {
                return(NA)
            }
        }
        else{
            if (!(num == "best" | num == "worst")) {
                stop("invalid num")
            }
        }

        result <-
            data.frame(hospital = "",
                       state = unique(outcome_data$State))
        ## For each state, find the hospital of the given rank

        if (outcome == "heart attack") {
            outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <-
                as.numeric(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
            outcome_data <-
                outcome_data[!is.na(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),]

            outcome_data <-
                outcome_data[order(
                    outcome_data$State,
                    outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
                    outcome_data$Hospital.Name
                ),]
            outcome_data$Rank <-
                unlist(with(
                    outcome_data,
                    tapply(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, State, function(x)
                        rank(x, ties.method = "first"))
                ))

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
                    outcome_data$State,
                    outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,
                    outcome_data$Hospital.Name
                ),]
            outcome_data$Rank <-
                unlist(with(
                    outcome_data,
                    tapply(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, State, function(x)
                        rank(x, ties.method = "first"))
                ))

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
                    outcome_data$State,
                    outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
                    outcome_data$Hospital.Name
                ),]
            outcome_data$Rank <-
                unlist(with(
                    outcome_data,
                    tapply(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, State, function(x)
                        rank(x, ties.method = "first"))
                ))
            if (debug) {
                print(outcome_data)
            }
        }

        ## Filter
        if (num == "best") {
            outcome_data <- outcome_data[outcome_data$Rank == 1, ]
        }
        else if (num == "worst") {
            ## Getting the max (worst) for each State
            statemax <-  with(outcome_data, tapply(Rank, State, function(x) max(x)))

            outcome_data <-
                outcome_data[outcome_data$Rank == statemax[finalresult$State], ]
        }
        else if (is.numeric(num)) {
            outcome_data <- outcome_data[outcome_data$Rank == num, ]
        }

        ## Format and return data
        result <-
            merge(
                result,
                outcome_data,
                by.x = "state",
                by.y = "State",
                all.x = TRUE,
                all.y = TRUE
            )
        result$hospital <- result$Hospital.Name
        result <- result[, 1:2]
        return(result)
    }

testRankhospital <- function(debug = FALSE) {

}
