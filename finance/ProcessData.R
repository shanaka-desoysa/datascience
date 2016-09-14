if (!require("dplyr")) {
    install.packages("dplyr")
}
library("dplyr")

processData <- function(dataFolderFormat = "./datatest/%Y%m%d", date = Sys.time()) {
    dataDir <- format(Sys.time(), dataFolderFormat)

    processedDir <- paste(dataDir, "processed", sep = "/")
    if (!file.exists(processedDir)) {
        dir.create(processedDir, recursive = T)
    }

    summaryDir <- paste(dataDir, "summary", sep = "/")
    summaryFile <- paste(summaryDir, format(Sys.time(), "%Y%m%d.csv"), sep = "/")

    if (!file.exists(summaryDir)) {
        dir.create(summaryDir, recursive = T)
    }

    if (!file.exists(summaryFile)) {
        write(paste("ticker", "price", "timestamp", sep = ","), summaryFile)
    }

    file.names <- dir(dataDir, pattern = ".csv")
    for (i in 1:length(file.names)) {
        file <- read.csv(paste(dataDir, file.names[i], sep = "/"))
        #write.csv(file[, c("t", "l", "lt_dts")], summaryFile, append = T)
        write.table(file[, c("t", "l_fix", "lt_dts")], file = summaryFile, row.names = F, col.names = F, append = T, sep = ",")
        file.rename(paste(dataDir, file.names[i], sep = "/"), paste(processedDir, file.names[i], sep = "/"))
    }
}

summariseData <- function(fileNameFormat = "./datatest/%Y%m%d/summary/%Y%m%d.csv") {
    require('dplyr')
    filePath <- format(Sys.time(), fileNameFormat)

    file <- read.csv(filePath, colClasses = c("character", "numeric", "character"))

    #library(reshape2)
    #melted <- melt(file, id.vars = c("ticker", "price", "timestamp"))
    #grouped <- group_by(melted, ticker)
    #summarise(grouped, mean = mean(value), sd = sd(value))
    df <- group_by(file, ticker) %>% summarise(mean = mean(price), median = median(price), sd = sd(price))
}


processData()

yy <- summariseData()
