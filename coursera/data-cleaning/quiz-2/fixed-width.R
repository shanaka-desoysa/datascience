fixedw <- read.fwf("getdata%2Fwksst8110.for", skip=4, header = F, widths = c(14, 5, 8, 5, 4, 9, 4, 9, 4))
head(fixedw)
fixedw[4]
print(sum(fixedw[4]))
