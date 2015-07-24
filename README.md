# Coursera "Getting and Cleaning Data" course project
## 1. Description
The repository contains a script, solving the task of preparing data
gathered by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory for the analysis
according to specifics in the program assignment.

The result of script execution is a tidy wide dataset, containing
average for every "mean" and "std" measurement, grouped by 
activity and subject.

## 2. Details
The script 'run_analysis.R' can be run in R, when there is data from the specified
project in the working directory in the folder 'UCI HAR Dataset'.
This data also is attached in the repository so you could download repository alltogether
and just run the script.
If you want to put the data in another directory and/or files, you can change
variables in the section #0. of the script, which have obvious descriptive names.

## 3. Script work
The script does following things:
* takes actual measurements from 'test' and 'train' folders, from 'X_test.txt' and 'X_train.txt'
and combines them into single dataset.
* attaches respective subject and activity information to every observation
* names the dataset column according to 'features.txt'. These names are descriptive, and have additional information in the .txt file if need arises.
* names the activity according to 'activity_labels.txt' (converting it into factors)
* selects columns for tidy dataset, which names contain 'mean()' or 'std()'
* groups dataset by activity and subject and computes average for every selected variable.

The result of script execution contains in 'tidy_set' variable. 
Also, the script writes data into 'tidy.txt' format using `write.table` function.
The attached to Course Project txt file could be read by user using
`read.table("tidy.txt", header = TRUE)` command.

## 4. Technical details
There is commented section in the end of the script, which contains alternative method
of average computation, which can be uncommented by curious user.