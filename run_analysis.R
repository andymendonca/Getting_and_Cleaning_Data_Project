# 1. Merge the training and test sets to create one data set.

# A. Read training and test tables and features and activity labels.
train_X_table <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
train_Y_table <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
train_subject_table <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
test_X_table <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test_Y_table <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
test_subject_table <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
features_file <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
activity_labels_file <- read.table('./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt')

# B. Assign and read simple names to different columns.
colnames(train_X_table) <- features_file[,2]
colnames(train_Y_table) <- "activityId"
colnames(train_subject_table) <- "subjectId"
colnames(test_X_table) <- features_file[,2]
colnames(test_Y_table) <- "activityId"
colnames(test_subject_table) <- "subjectId"
colnames(activity_labels_file) <- cbind("activityId", "activityType")

# C. Merge training and test sets into one data set.

train_set_merge <- cbind(train_Y_table, train_subject_table, train_X_table)
test_set_merge <- cbind(test_Y_table, test_subject_table, test_X_table)
merge_in_one <- rbind(train_set_merge, test_set_merge)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.

# A. Read every single column name.
columnNames <- colnames(merge_in_one)

# B. Create a vector for the ID, mean, and standard deviation columns.
mean_standardDev <- (grepl("activityId", columnNames) | grepl("subjectId", columnNames) |
                     grepl("mean...", columnNames) | grepl("std...", columnNames))

# C. Make a subset from merge_in_one.
set_mean_standardDev <- merge_in_one[, mean_standardDev == TRUE]

# 3. Use descriptive activity names to name the activities in the data set.

# A. Merge the set_mean_standardDev set with the activity_labels_file table to include descriptive activity names.
set_activity_names <- merge(set_mean_standardDev, activity_labels_file, by = "activityId", 
                            all.x = TRUE)

# B. Update the columnNames vector to include new column names.
columnNames = colnames(set_activity_names)

# 4. Appropriately label the data set with descriptive variable names.

# A. Clean up every single variable name.
for(i in 1:length(columnNames))
{
  columnNames[i] = gsub("\\()", "", columnNames[i])
  columnNames[i] = gsub("std", "StdDev", columnNames[i])
  columnNames[i] = gsub("mean", "Mean", columnNames[i])
  columnNames[i] = gsub("^(t)", "time", columnNames[i])
  columnNames[i] = gsub("^(f)", "freq", columnNames[i])
  columnNames[i] = gsub("([Gg]ravity)", "Gravity", columnNames[i])
  columnNames[i] = gsub("([Bb]ody[Bb]ody | [Bb]ody)", "Body", columnNames[i])
  columnNames[i] = gsub("[Gg]yro", "Gyro", columnNames[i])
  columnNames[i] = gsub("AccMag", "AccMagnitude", columnNames[i])
  columnNames[i] = gsub("([Bb]odyaccjerkmag)", "BodyAccJerkMagnitude", columnNames[i])
  columnNames[i] = gsub("JerkMag", "JerkMagnitude", columnNames[i])
  columnNames[i] = gsub("GyroMag", "GyroMagnitude", columnNames[i])
}

# B. Reassign new column names to the set_activity_names set. 
colnames(set_activity_names) = columnNames

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

# A. Make a second tidy data set.
tidy_data_set <- aggregate(. ~subjectId + activityId, set_activity_names, mean)
tidy_data_set < tidy_data_set[order(tidy_data_set$subjectId, tidy_data_set$activityId),]

# B. Write the second tidy data set in a text file.
write.table(tidy_data_set, "tidydataset.txt", row.name = FALSE)