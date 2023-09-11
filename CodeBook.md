This project will follow the next steps in order to prepare the data:
1. **Download the dataset (*importing.R*)**
   * Download the dataset using download.file and storing it with the name *JHUCDW4.zip* in the current working directory.
   * Unzip the file *JHUCDW4.zip* which creates a **UCI HAR Dataset** directory
2. **Import data files (*importing.R*)**
   * activities <- activity_labels.txt : 6 obs, 2 variables.   List of activities performed and their code.
   * features <- features.txt : 561 obs, 2 variables.   The features of X_train and X_test, they come from the accelerometer and gyroscope 3-axial raw signals.
   * test_sub <- subject_test.txt : 2947 obs, 1 variables.   Volunteer test set subjects being observed.
   * train_sub <- subject_train.txt : 7352 obs, 1 variables.   Volunteer train set subjects being observed.
   * test_x <- X_test.txt : 2947 obs, 561 variables.   Contains recorded features in test set.
   * train_x <- X_train.txt : 7352 obs, 561 variables.   Contains recorded features in train set.
   * test_y <- y_test.txt : 2947 obs, 1 variables.   Contains code labels of activities in test set.
   * train_y <- y_train.txt : 7352 obs, 1 variables.   Contains code labels of activities in train set.
3. **Merges the training and the test sets to create one data set**
   * sub (10299 obs, 1 variables) is created by merging train_sub and test_sub using rbind() then using setNames to rename columns. 
   * x (10299 obs, 561 variables) is created by concatenating train_x and test_x using rbind() then using setNames to rename columns. 
   * y (10299 obs, 1 variables) is created by concatenating train_y and test_y using rbind() then using setNames to rename columns. 
   * df (10299 obs, 563 variables) is created by merging sub, y and x using cbind()
4. **Extracts only the measurements on the mean and standard deviation for each measurement**
   * df_1 (10299 obs, 88 variables) is created by selecting the Subject, Code, mean measurements and standard deviation measurements columns. Using *select(Subject, Code, contains(c("mean", "std"))*
5. **Uses descriptive activity names to name the activities in the data set**
   * Performing a left join with activities on Code column then mutate the columns to update as a factor, relocate to have the factor column after Subject column and dropping the Code column ends with a df_activity (10299 obs, 88 variables)
6. **Appropriately labels the data set with descriptive variable names**
   * Freq in columns names replaced by Frequency
   * Start with t in columns names or after '(' replaced by Time
   * Start with f in columns names replaced by Frequency
   * Eliminate empty parenthesis ().
   * Replaced mean and std to Mean and STD.
   * Replaced All Acc to Accelerometer.
   * Replaced All Gyro to Gyroscope.
   * Replaced All BodyBody to Body.
   * Replaced All Mag to Magnitude.
   * Replaced All angle to Angle.
7. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
   * tidy_data (180 obs, 88 variables) is created by grouping by Subject and Activity then sumarizing all columns to get the mean.
   * export the result table with write.txt() function.
