library(dplyr)
library(reshape2)
library(readr)

colNames <- read.table("UCI HAR Dataset/features.txt",header = FALSE)

# We don't need the first column of the names so drop it:
colNames <- colNames["V2"]

# Make all the variable names lower case:
colNames <- tolower(colNames$V2)

# Drop the parentheses:
colNames <- gsub("\\(|\\)", "", colNames)

# Drop the dashes:
colNames <- gsub("-", "", colNames)

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = colNames)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = colNames)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

names(y_test) <- "activity"
names(y_train) <- "activity"
names(subject_test) <- "subject"
names(subject_train) <- "subject"

test <- cbind(subject_test, X_test, y_test)
train <- cbind(subject_train, X_train, y_train)

merged <- rbind(test,train)

means <- grepl("mean|std|^activity$|^subject$", names(merged))

merged_set <- merged[,means]

merged_set$activity <- factor(merged_set$activity,labels = as.character(activity_labels$V2))

melted_set <- melt(merged_set, id = c("subject", "activity"))

final_tidy <- dcast(melted_set, subject+activity ~ variable, mean)

write.table(final_tidy, "final_tidy.txt", row.names=FALSE)

