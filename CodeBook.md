## Description

Important information regarding the variables, data, and transformations
used in the course project for the Getting and Cleaning Data course.


## Source data information

A full description of the data being used for this project is found
on this website:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

This is the link to the data that was used for this project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


## R Script information

Explanation of file "run_analysis.R" performing 5 simple required steps for the project:

1.  Merge the training and the test sets to create one data set.

  A.  Read training and test tables and features and activity labels.
  
  B.  Assign and read simple names to different columns.
  
  C.  Merge training and test sets into one data set.
  
2. Extract only the measurements on the mean and standard deviation for each measurement.

  A.  Read every single column name.
  
  B.  Create a vector for the ID, mean, and standard deviation columns.
  
  C.  Make a subset from merge_in_one.
  
3.  Use descriptive activity names to name the activities in the data set.

  A.  Merge the set_mean_standardDev set with the activity_labels_file table to include descriptive activity names.
  
  B.  Update the columnNames vector to include new column names.

4.  Appropriately label the data set with descriptive variable names.

  A.  Clean up every single variable name.
  
  B.  Reassign new column names to the set_activity_names set.
  
5.  Create a second, independent tidy data set with the average of each variable for each activity and each subject.

  A.  Make a second tidy data set.
  
  B.  Write the second tidy data set in a text file.
  
  
## Variable information

* `train_X_table`- contains data from the file `X_train.txt`
* `train_Y_table`- contains data from the file `Y_train.txt`
* `train_subject_table`- contains data from the file `subject_train.txt`
* `test_X_table`- contains data from the file `X_test.txt`
* `test_Y_table`- contains data from the file `Y_test.txt`
* `test_subject_table`- contains data from the file `subject_test.txt`
* `features_file`- contains features from the file `features.txt`
* `activity_labels_file`- contains activity labels from the file `activity_labels.txt`
* `train_set_merge`- merges all training files
* `test_set_merge`- merges all test files
* `merge_in_one`- merges training and test files into one data set
* `columnNames`- contains all column names
* `mean_standardDev`- contains vectors for the ID, mean, and standard deviation columns
* `set_mean_standardDev`- a subset from the `merge_in_one` data set
* `set_activity_names`- contains descriptive activity names
* `tidy_data_set`- contains the average of each variable for each activity and each subject
