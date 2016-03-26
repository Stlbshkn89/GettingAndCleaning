# Getting And Cleaning Data 
## Data Science Spealization
### Course Project
#### 1. What should I do?
> Here are the data for the project:

> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

> You should create one R script called run_analysis.R that does the following.

> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names.
> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### 2. What I've done
The following files are used in this project:
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt', 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Let's load test and train data sets, subjects and labels for measurements

    library(dplyr)
    test <- read.table("./test/X_test.txt")
    test_labels <- read.table("./test/y_test.txt")
    test_subj <- read.table("./test/subject_test.txt")
    train <- read.table("./train/X_train.txt")
    train_labels <- read.table("./train/y_train.txt")
    train_subj <- read.table("./train/subject_train.txt")
    feat <- read.table("features.txt")
    
Then we should bind columns of training and test data frames with activity names and subject who performed activities

    test <- cbind(test_subj$V1, test_labels$V1, test)
    train <- cbind(train_subj$V1, train_labels$V1, train)

Let's merge dataframes and assign the names to the variables

    colnames(test) <- c("Subject", "Activity", as.character(feat$V2))
    colnames(train) <- c("Subject", "Activity", as.character(feat$V2))
    df <- rbind(train, test)

