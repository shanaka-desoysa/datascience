# install.packages("sqldf")
library(sqldf)
acs <- read.csv("getdata%2Fdata%2Fss06pid.csv")
# sqldf("select pwgtp1 from acs where AGEP < 50")
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")
