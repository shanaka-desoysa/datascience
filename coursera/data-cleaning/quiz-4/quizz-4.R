dataFolder = "./data"
# dataFile = "./data/housing.csv"
# dataFileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# dataFile = "./data/edu.csv"
# dataFileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
#
#
# if(!file.exists(dataFolder)) {
#     dir.create(dataFolder)
# }
# if (!file.exists(dataFile)){
#     download.file(dataFileUrl, destfile = dataFile)
# }

# csvData = read.csv(dataFile)
# strsplit(names(csvData), "wgtp")

# gdpData = read.csv("./data/gdp.csv", skip = 4,nrows = 190, col.names = c("CountryCode", "Ranking", "Blank", "Country", "Economy","","","","",""), strip.white = TRUE)
# csvData$GDP = as.numeric(gsub(",", "", csvData$Economy))
# print(mean(csvData$GDP))
#
# eduData = read.csv("./data/edu.csv")
# mrg = merge(eduData, gdpData)
# grep("Fiscal year end: June 30", mrg$Special.Notes, value = T)

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
# length(grep("2012", sampleTimes))
# length(sampleTimes[format(sampleTimes, "%Y") == "2012"])
length(sampleTimes[format(sampleTimes, "%Y") == "2012" & format(sampleTimes, "%a") == "Mon"])
