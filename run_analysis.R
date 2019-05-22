setwd("C:/Users/ahpasupala1/Downloads")
library(dplyr)

# Checking if archieve already exists.
if (!file.exists("getdata_projectfiles_UCI HAR Dataset")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  

# Checking if folder exists
if (!file.exists("getdata_projectfiles_UCI HAR Dataset")) { 
  unzip(filename) 
}

activity_labels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "Activity"))
features <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", col.names = c("n", "features"))

# train Dataset
subject_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", col.names = features$features)
y_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", col.names = "code")

# test Dataset 
subject_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", col.names = features$features)
y_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", col.names = "code")

# Merge the training and test sets to create one data set. 
X <- rbind(X_train, X_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# Extract measurements on mean and standard deviation for each measurements
Data <- Merged_Data%>% select(subject, code, contains("mean"), contains("std"))

# Uses Descriptive activity names to name the activities in the data set
Data$code <- activity_labels[Data$code, 2]

# Appropriate labels the data set with descriptive variable names
names(Data)[2] = "activity"
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("^t", "Time", names(Data))
names(Data) <- gsub("^f", "Frequency", names(Data))
names(Data) <- gsub("tBody", "TimeBody", names(Data))
names(Data) <- gsub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data) <- gsub("-std()", "STD", names(Data), ignore.case = TRUE)
names(Data) <- gsub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data) <- gsub("angle", "Angle", names(Data))
names(Data) <- gsub("gravity", "Gravity", names(Data))

# From the data, create a second, independent tidy data set with the average of each variable
# for each activity and each subject
FinalData <- Data %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))

write.table(FinalData, "getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/FinalData.txt", row.name=FALSE)

