## This script downloads, unzips, and then load the data files into data frames



download_and_unzip <- function() {
        ## Download the zip archive if it has not been downloaded yet
        if (! file.exists("data.zip")) {
                url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(url, "data.zip")
        }
        
        ## Unzip the archive if needed
        if (! file.exists("UCI HAR Dataset")) unzip("data.zip")
        
        ## set working directory
        setwd("UCI HAR Dataset")
}



## Read the X_test files
read_X_test <- function(type) {
        
        # Test if type is either test or train
        if (! type %in% c("test", "train")) {
                stop("\'type' argument is not either 'test' or
                     'train'!")
        }
        
        # Get the path to the data file
        dirpath <- paste0(type, "/X_", type, ".txt")
        # Read data file
        data <- read.table(dirpath)
        
        return (data)
}



## Read the subject_test and y_test files (vector files)
read_vector_files <- function(type, vector) {
        
        # Test if type is either test or train or if vector is
        # either subject or y
        if (! (type %in% c("test", "train") &
               vector %in% c("subject", "y"))) {
                stop("\'type' argument is not either 'test' or 'train' or
                        'vector' argument is not either 'subject' or 'y'.")
        }
        
        # Construct path to the data file
        path = paste0(type, "/", vector, "_", type, ".txt")
        # Read data file into a vector
        column <- scan(path)
        
        return (column)
}



## Read names from the file 'features.txt'
read_names <- function() {
        
        ## The elements of 'names' will be of the form '1 abc', '2 xyz', ...
        names <- readLines("features.txt")
        
        ## Use regular expressions to remove all characters up to and
        ## including the first white space
        names <- sub(".*? (.+)", "\\1", names)
        
        return (names)
}