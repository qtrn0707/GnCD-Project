# **READ ME**
------------------

**This read me explains the script *run_analysis.R*.**

## Download and unzip the original data
The data is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip using *download.file()* (if necessary).

It is then unzipped using the function *unzip()* (if necessary).

The data is stored in the newly unzipped folder *UCI HAR Dataset*. This folder is set as the working directory.

All of this is wrapped in the function *download_and_unzip* in the script *get_data.R*

## Task 1: Merge the training and the test sets to create one data set

The one unified data set will be called *data*.

Initially, the test data is assigned to *data*. After that, *rbind()* is used to concatenate the training data to *data*.

The variables names (obtained from *features.txt* of the original archive) are then added. **Note: this will also complete Task 4.**

Finally, the subject and the activity are added into two variables *subject* and *activity* respectively.

## Task 2: Extract only the measurements on the mean and standard deviation for each measurement.

The output will be called *mnsdData*.

First, *grepl()* is used to get the column indices of the variables that end with either *mean()* or *std()*.
I then use the resulting logical vector to obtain the names of the variables that end with either *mean()* or *std()*.

*mnsdData* is initialized with the required number of rows and 0 columns. Then, using a *for* loop, columns are added to *mnsdData* one by one.

Finally, the variables *subject* and *activity* are added to *mnsdData*.

## Task 3: Use descriptive activity names to name the activities in the data set

Simply use the function *factor()* to add labels to the variable *activity* in the data frame *data*.

## Task 4: Appropriately label the data set with descriptive variable names

See paragraph 3 in Task 1 (when the variable names are added to the big merged data set).

## Task 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

To do this, we need the functions *melt()* and *dcast()* from the library *reshape2*.

First, melt *mnsdData* using the function *melt()* where the ids are *subject* and *activity*. The resulting long and narrow data set is stored in *mnsdDataMelt*.

Second, cast *mnsdDataMelt* using *dcast()* where the aggregate function argument is *mean*. The data set required is obtained, and then saved in *averageMnsdData*.

Third, write *averageMnsdData* into a *.txt* table using *write.table()*. The data file *averageMnsdData.txt* is saved in the folder *UCI HAR Dataset*.

--------------------------------------------------------

**Final note: At the end of the script, the working directory is reset to the parent directory of *UCI HAR Dataset*.**
