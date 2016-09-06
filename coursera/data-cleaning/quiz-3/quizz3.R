# # download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "housing.csv")
# housing = read.csv("housing.csv")
# agricultureLogical = with(housing, ACR == 3 & AGS == 6)
#
# print(which(agricultureLogical))

# library("jpeg")
# # download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "img.jpg")
# img = readJPEG("jeff.jpg", native = TRUE)

# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "gdp.csv")
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "edu.csv")
gdp = read.csv("gdp.csv", skip = 4,nrows = 190, col.names = c("CountryCode", "Ranking", "Blank", "Country", "Economy","","","","",""))
edu = read.csv("edu.csv")
mrg = merge(edu, gdp)
mrg <- mrg[order(mrg$Ranking, decreasing = TRUE),]

# OECD = mrg[which(mrg$Income.Group == "High income: OECD"),]
# print(mean(OECD$Ranking))
# nonOECD = mrg[which(mrg$Income.Group == "High income: nonOECD"),]
# print(mean(nonOECD$Ranking))

breaks = quantile(mrg$Ranking, seq(0, 1, 0.2), na.rm = TRUE)
mrg$quantileGDP = cut(mrg$Ranking, breaks = breaks)

# install.packages("data.table")
library("data.table")
mrg=data.table(mrg, keep.rownames = TRUE)

 x=mrg[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]

