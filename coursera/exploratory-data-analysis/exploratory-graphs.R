dataFolder <- "./data"
dataFile <- "./data/avgpm25.csv"

pollutant <- read.csv(dataFile)
print(head(pollutant))

# 6 point summary
print(summary(pollutant$pm25))

# Boxplot
boxplot(pollutant$pm25, col = "blue")

# Histogram, with rug
hist(pollutant$pm25, col = "green")
rug(pollutant$pm25)

# Histogram breaks
hist(pollutant$pm25, col = "green", breaks = 100)
rug(pollutant$pm25)

# Boxplot with overlaying line at 12
boxplot(pollutant$pm25, col = "blue")
abline(h = 12)

# Histogram with overlaying median and 12
hist(pollutant$pm25, col = "green")
rug(pollutant$pm25)
abline(v = 12, lwd = 2)
abline(v = median(pollutant$pm25),
       lwd = 4,
       col = "magenta")

# Barplot
barplot(table(pollutant$region), col = "wheat", main = "Number of Counties in Each Region")

