# HUMAN ACTIVITY RECOGNITION USING SMARTPHONES

## Dataset
[Human Activity Recognition Using Smartphones](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Files
* run_analysis.R performs the data preparation and then followed by the 5 steps required as described in the course project’s definition:
  * Merges the training and the test sets to create one data set.
  * Extracts only the measurements on the mean and standard deviation for each measurement.
  * Uses descriptive activity names to name the activities in the data set
  * Appropriately labels the data set with descriptive variable names.
  * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* FinalData.txt is the exported final data after going through all the sequences described above.

## Prerequistite Packages
If not already installed, be sure to install the following packages in R:
* dplyr
* data.table

For installing packages
install.packages(c("dplyr", "data.table"))


