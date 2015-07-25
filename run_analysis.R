# The script for Coursera "Getting and Cleaning Data" course project.
# The script takes data in getdata_projectfiles_UCI HAR Dataset.zip
# in the working directory and processes it according to all
# specified steps in task.

# 0. load librarys
library(dplyr)
library(reshape2)

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

# this is looking up classes for big speedup to read.table
train_set_classes = sapply(read.table(train_set_file_name, nrows=5), class)
test_set_classes = sapply(read.table(test_set_file_name, nrows=5), class)
# We cbind subject IDs with activity IDs with data and label them
# according to 1.1 lables
dataset <- 
        rbind(
                cbind(
                        read.table(train_set_subjects_file_name),
                        read.table(train_set_activtiy_file_name),
                        read.table(train_set_file_name, colClasses = train_set_classes,
                                   col.names = tbl_features$V2)
                ),
                cbind(
                        read.table(test_set_subjects_file_name),
                        read.table(test_set_activity_file_name),
                        read.table(test_set_file_name, colClasses = test_set_classes,
                                   col.names = tbl_features$V2)
                )
        )
remove(train_set_classes, test_set_classes)
colnames(dataset)[1:2] <- c("subject", "activity")

# 2. Select only columns which have 'mean' or 'std' in label:
# As the read.table makes column run through make.names to
# be syntactical valid, our names will have dots in the tail.
# We need it to exclude variables like meanFreq

small_dataset  <- select(dataset, 
                         c(1, 2, # the subject and activity columns
# and the regular expression for mean() or std() in the variable name
# the reason why we don't do grep on the column.names themselves
# is that the variable name in R doesn't allow for parenthesis,
# so the read.table changes those into dots, and then we have 'bad'
# variables whose names match pattern. +2 exists because of additional
# preceding columns in our dataset.
                          which(grepl("mean\\(\\)|std\\(\\)", tbl_features$V2)) + 2))

# 3. Transform numerical activity code into factor with names
# from activity_labels.txt, read into table in tbl_labels
small_dataset[[2]] <- factor(dataset[[2]], labels=tbl_labels$V2)

# 4. Label the data
# The data is already labeled in p.1.2 during the reading.

# 5. From the data set, create a second, independent tidy dataset with 
# average of each variable for each activity and each subject
# we use the summarise_each from dplyr, essentiale the summarise
# function for all non-grouped variables in this context.

# the assignment says 'for each activity and each subject'
# so i've changed the order to following:
# 1st grouping column is Activity
# 2nd grouping column is Subject.
# if needed, you can easily change the order of grouping in the
# next formula

melted <- melt(small_dataset,id.vars = c("subject","activity"))
tidy_set <- dcast(melted,
                  activity + subject ~ variable ,
                  fun.aggregate = mean)

# The alternative variant using dplyr, not reshape.
# It is faster, but requires careful use due to NSE (read about it,
# it will save your time in the future)
#groups <- list(~subject, ~activity)
#grouped_set <- group_by_(small_dataset, .dots = groups)
#tidy_set <- summarise_each(grouped_set, c("mean"))

# 6. Export data into text file
write.table (tidy_set, file="tidy.txt", row.names = FALSE)