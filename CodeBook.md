# Getting and Cleaning Data Course Project CODEBOOK

## 1. The data description
The dataset created by running 'run_analysis.R' script is a cleaned and prepared data from

Human Activity Recognition Using Smartphones Dataset
Version 1.0
www.smartlab.ws
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The original dataset contained data from experiment with measuring human activities using
accelerometers and gyroscopes inside Samsung smartphones. The multiple measurement were made
on 30 volunteers and 6 types of activities. Original dataset contained 561 variable.

The work performed on the dataset was to select from all measured variables only means and standard
deviations of corresponding parameters, and to aggregate those variables by
calculating average by every activity and every subject.

## 2. Variable description
The result tidy dataset is in wide format, contains 180 observations of 68 variables, 180 being 6 activities * 30 subjects combinations.

The columns are
* Activity, which is a factor variable of 6 possible values



1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

* Subject, which is a numeric variable, with possible values from 1 to 30.
* Other 66 variables, according to original scheme:

signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

    tBodyAcc-XYZ
    tGravityAcc-XYZ
    tBodyAccJerk-XYZ
    tBodyGyro-XYZ
    tBodyGyroJerk-XYZ
    tBodyAccMag
    tGravityAccMag
    tBodyAccJerkMag
    tBodyGyroMag
    tBodyGyroJerkMag
    fBodyAcc-XYZ
    fBodyAccJerk-XYZ
    fBodyGyro-XYZ
    fBodyAccMag
    fBodyAccJerkMag
    fBodyGyroMag
    fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

    mean(): Mean value
    std(): Standard deviation

The unit measurements for last 66 columns original signals are m/s^2,
but they were normalized and bound to [-1,1] in the original data,
so by the nature of average function result variables have the same restrictions.