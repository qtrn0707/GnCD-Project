source("get_data.R")



## Download and unzip the dataset (This will change the working directory to
## 'UCI HAR Dataset')
download_and_unzip()



## Merges the training and the test sets to create one data set.
## It will be called 'data' (TASK 1)
data <- read_X_test("test")
data <- rbind.data.frame(data, read_X_test("train"))
# Add names (TASK 4)
names(data) <- read_names()
# Add two more variables subject and y
data$subject <- c(read_vector_files("test", "subject"),
                  read_vector_files("train", "subject"))
data$activity <- c(read_vector_files("test", "y"),
                        read_vector_files("train", "y"))



## Extracts only the measurements on the mean and standard deviation
## for each measurement. The ouput will be called 'mnsdData' (TASK 2)

# Get the variables that are either means or stds
names <- names(data)
mnsdIndicesL <- grepl("mean()", names) | grepl("std()", names)
mnsdNames <- names[mnsdIndicesL]
# Collect the means and stds variables from the big data set
mnsdData <- data.frame(matrix(nrow = nrow(data), ncol=0))
for (name in mnsdNames) {
        mnsdData[[name]] <- data[[name]]
}
# Add in 'subject' and 'activity' columns
mnsdData$subject <- data$subject
mnsdData$activity <- data$activity



## Recode the name of the activities from number into factors describing the
## actual activity (TASK 3)
data$activity <- factor(data$activity,
                        labels = c("WALKING", "WALKING_UPSTAIRS",
                                   "WALKING_DOWNSTAIRS", "SITTING",
                                   "STANDING", "LAYING"))



## Create a second, independent tidy data set with the average of each variable
## for each activity and each subject

# First, melt the big data set into a long, narrow one with four columns:
# 'subject', 'activity', 'variable', 'value'
library(reshape2)
mnsdDataMelt <- melt(mnsdData, id = c("subject", "activity"))

# Second, cast the melted data set and take the means of each activity for
# each activity and each subject
averageMnsdData <- dcast(mnsdDataMelt, subject + activity ~ variable, mean)

## Third, write 'averageMnsdData' into a .txt table
write.table(averageMnsdData, "averageMnsdData.txt", row.names = FALSE)



## To end the script, change the working directory back to the original one
setwd("..")