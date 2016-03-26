library(dplyr)
#Importing test, train, list of subjects and labels for measurements
test <- read.table("./test/X_test.txt")
test_labels <- read.table("./test/y_test.txt")
test_subj <- read.table("./test/subject_test.txt")
train <- read.table("./train/X_train.txt")
train_labels <- read.table("./train/y_train.txt")
train_subj <- read.table("./train/subject_train.txt")

#Binding labels, subjects with train and test df (separately)
test <- cbind(test_subj$V1, test_labels$V1, test)
train <- cbind(train_subj$V1, train_labels$V1, train)

#Reading features
feat <- read.table("features.txt")

#Naming the columns of our datafrane
colnames(test) <- c("Subject", "Activity", as.character(feat$V2))
colnames(train) <- c("Subject", "Activity", as.character(feat$V2))

#Final dataset
df <- rbind(train, test)
#Removing all previouse data frames because we don't need them anymore
rm(test, test_labels, test_subj, train, train_subj, train_labels, feat)

#Naming the activities (but before convertin to factors)
activity_labels <- read.table("activity_labels.txt")
df$Activity <- factor(df$Activity, labels = activity_labels$V2)
#Thanks stackoverflow for the hint below
valid_column_names <- make.names(names=names(df), unique=TRUE, allow = TRUE)
names(df) <- valid_column_names

#Searching for mean. and std. (but not for meanFreq and stdFreq)
df1 <- select(df, Subject, Activity, grep("mean[.]|std[.]", colnames(df)))
df1 <- group_by(df1, Subject, Activity)
answer <- summarise_each(df1, funs(mean))
write.table(answer, "output.txt", row.names = FALSE)