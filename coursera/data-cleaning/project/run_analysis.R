dataFolder <- "./data"
dataFile <- "./data/Dataset.zip"
dataFileUrl <-
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Create data folder
if (!file.exists(dataFolder)) {
    dir.create(dataFolder)
}
# Download data file
if (!file.exists(dataFile)) {
    download.file(dataFileUrl, destfile = dataFile)
}
# Unzip
unzip(dataFile, exdir = dataFolder)

# Set working data folder
if (file.exists(paste(dataFolder, "/UCI HAR Dataset", sep = ""))) {
    dataFolder = paste(dataFolder, "/UCI HAR Dataset", sep = "")
} else {
    stop("Data folder not found.")
}

# Features
features <- read.table(paste(dataFolder, "/features.txt", sep = ""),
                       colClasses = c("integer", "character"))
features <- features[, 2]

# Read Test dataset with labels
test.x <- read.table(
    paste(dataFolder, "/test/X_test.txt", sep = ""),
    col.names = features,
    header = F
)
test.y <- read.table(
    paste(dataFolder, "/test/y_test.txt", sep = ""),
    col.names = "Activity",
    header = F
)
test.subject <- read.table(
    paste(dataFolder, "/test/subject_test.txt", sep = ""),
    col.names = "Subject",
    header = F
)

# Read Training dataset with labels
train.x <- read.table(
    paste(dataFolder, "/train/X_train.txt", sep = ""),
    col.names = features,
    header = F
)
train.y <- read.table(
    paste(dataFolder, "/train/y_train.txt", sep = ""),
    col.names = "Activity",
    header = F
)
train.subject <- read.table(
    paste(dataFolder, "/train/subject_train.txt", sep = ""),
    col.names = "Subject",
    header = F
)


#
# 1. Merges the training and the test sets to create one data set.
#

# Create Test data frame binding columns
test <- cbind(test.subject, test.y, test.x)

# Create Training data frame binding columns
train <- cbind(train.subject, train.y, train.x)


# Merge training and test datasets
mergedData <- rbind(train, test)

# Cleanup intermediate variables
rm(list = ls(pattern = "test"))
rm(list = ls(pattern = "train"))
rm(features)


#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#
mergedData <-
    mergedData[, grepl("\\.mean|\\.std|Activity|Subject", names(mergedData))]


#
# 3. Uses descriptive activity names to name the activities in the data set
#

# Activity labels
activities <- read.table(
    paste(dataFolder, "/activity_labels.txt", sep = ""),
    colClasses = c("integer", "character"),
    col.names = c("id", "Activity")
)
mergedData$Activity <- factor(mergedData$Activity,
                              levels = activities$id,
                              labels = activities$Activity)


#
# 4. Appropriately labels the data set with descriptive variable names.
#

columns <- colnames(mergedData)
columns <- sub("^t", "Time.", columns)
columns <- sub("^f", "Freq.", columns)
columns <- sub("(Body)+", "Body", columns)
columns <- sub("Acc", ".Accelaration", columns)
columns <- sub("Mag", ".Magnitude", columns)
columns <- sub("Gyro", ".AngularVelocity", columns)
columns <- sub("mean", "Mean", columns)
columns <- sub("std", "StandardDeviation", columns)
columns <- sub("\\.(\\.)+", "", columns)
columns <- sub("X$", ".X", columns)
columns <- sub("Y$", ".Y", columns)
columns <- sub("Z$", ".Z", columns)

colnames(mergedData) <- columns

#
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

library(plyr)
tidyData <- aggregate(. ~ Subject + Activity, mergedData, mean)
write.table(tidyData, file = "./data/tidyData.txt", row.names = F)
