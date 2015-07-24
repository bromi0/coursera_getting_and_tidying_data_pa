# The script for Coursera "Getting and Cleaning Data" course project.
# The script takes data in getdata_projectfiles_UCI HAR Dataset.zip
# in the working directory and processes it according to all
# specified steps in task.

# 0. load librarys
library(dplyr)

# 1. Read data and merge sets

# 1.1. Read Labels
labels_file_name <- "./UCI HAR Dataset/activity_labels.txt"
features_file_name <- "./UCI HAR Dataset/features.txt"

tbl_labels = read.table(labels_file_name)
tbl_features = read.table(features_file_name)

# 1.2. Read Data set
train_set_subjects_file_name <- "./UCI HAR Dataset/train/subject_train.txt"
train_set_file_name <- "./UCI HAR Dataset/train/X_train.txt"
train_set_activtiy_file_name <- "./UCI HAR Dataset/train/y_train.txt"
test_set_subjects_file_name <- "./UCI HAR Dataset/test/subject_test.txt"
test_set_file_name <- "./UCI HAR Dataset/test/X_test.txt"
test_set_activity_file_name <- "./UCI HAR Dataset/test/y_test.txt"

# We cbind subject IDs with activity IDs with data and label them
# according to 1.1 lables
dataset <- 
        rbind(
                cbind(
                        read.table(train_set_subjects_file_name),
                        read.table(train_set_activtiy_file_name),
                        read.table(train_set_file_name, 
                                   col.names = tbl_features$V2)
                ),
                cbind(
                        read.table(test_set_subjects_file_name),
                        read.table(test_set_activity_file_name),
                        read.table(test_set_file_name,
                                   col.names = tbl_features$V2)
                )
        )
colnames(dataset)[1:2] <- c("subject", "activity")

# 2. Select only columns which have 'mean' or 'std' in label:
# As the read.table makes column run through make.names to
# be syntactical valid, our names will have dots in the tail.
# We need it to exclude variables like meanFreq

small_dataset <- select(dataset, matches("subject|activity|mean\\.|std\\.", ignore.case=TRUE))

# 3. Transform numerical activity code into factor with names
# from activity_labels.txt, read into table in tbl_labels
small_dataset[[2]] <- factor(dataset[[2]], labels=tbl_labels$V2)


