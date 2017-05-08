library(dplyr)

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "\n")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "\n")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

colnames(subject_test) <- c("subject_test")
colnames(X_test) <- c("X")
colnames(y_test) <- c("y")

colnames(subject_train) <- c("subject_train")
colnames(X_train) <- c("X")
colnames(y_train) <- c("y")

test <- mutate(subject_test, "X" = as.character(X_test$X), "y" = y_test$y)
train <- mutate(subject_train, "X" = as.character(X_train$X), "y" = y_train$y)