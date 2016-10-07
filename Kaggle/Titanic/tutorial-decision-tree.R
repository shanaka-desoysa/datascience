require("rpart")
train <- read.csv("train.csv")
test <- read.csv("test.csv")
# Your train and test set are still loaded in
str(train)
str(test)

# Build the decision tree
my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

# Visualize the decision tree using plot() and text()
plot(my_tree_two)
text(my_tree_two)

# Load in the packages to build a fancy plot
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# Time to plot your fancy tree
fancyRpartPlot(my_tree_two)

# my_tree_two and test are available in the workspace


# Make predictions on the test set
my_prediction <- predict(my_tree_two, test, type = "class")

# Finish the data.frame() call
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Use nrow() on my_solution
nrow(my_solution)

# Finish the write.csv() call
write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)


# Your train and test set are still loaded in

# Change this command
my_tree_three <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked,
                       data = train, method = "class", control = rpart.control(minsplit = 50, cp = 0))

# Visualize my_tree_three
fancyRpartPlot(my_tree_three)

# train and test are available

# Create train_two
train_two <- train
train_two$family_size <- train_two$SibSp + train_two$Parch + 1

# Finish the command
my_tree_four <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + family_size,
                      data = train_two, method = "class")

## Visualize your new decision tree
#fancyRpartPlot(my_tree_four)

## train_new and test_new are available in the workspace

## Finish the command
#my_tree_five <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title,
                      #data = train_new, method = "class")

## Visualize my_tree_five
#fancyRpartPlot(my_tree_five)

## Make prediction
#my_prediction <- predict(my_tree_five, test_new, type = "class")

## Make results ready for submission
#my_solution <- data.frame(PassengerId = test_new$PassengerId, Survived = my_prediction)
#write.csv(my_solution, file = "my_solution2.csv", row.names = FALSE)

################
## Considering whether Cabin is available
train_three <- train
test_three <- test

train_three$FamilySize <- train_three$SibSp + train_three$Parch + 1
test_three$FamilySize <- test_three$SibSp + test_three$Parch + 1

train_three$CabinValid <- train_three$Cabin != ""
test_three$CabinValid <- test_three$Cabin != ""

# Change this command
my_tree_six <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + FamilySize + Fare + Embarked + CabinValid,
                       data = train_three, method = "class", control = rpart.control(minsplit = 50, cp = 0))


# Visualize my_tree_three
fancyRpartPlot(my_tree_six)

# Make predictions on the test set
my_prediction <- predict(my_tree_six, test_three, type = "class")

# Finish the data.frame() call
my_solution <- data.frame(PassengerId = test_three$PassengerId, Survived = my_prediction)

# Use nrow() on my_solution
nrow(my_solution)

# Finish the write.csv() call
write.csv(my_solution, file = "my_solution3.csv", row.names = FALSE)
