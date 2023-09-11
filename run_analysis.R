#### Step1 - Merge the training and the test sets to create one data set ####

# Concatenate all the dataframes and merge the columns
library(dplyr)
source("importing.R")
sub <- rbind(test_sub, train_sub) %>% setNames(c("Subject"))
x <- rbind(test_x, train_x) %>% setNames(features$names)
y <- rbind(test_y, train_y) %>% setNames("Code")
df <- cbind(sub, x, y)
rm(list = ls()[!grepl("df|activities", ls())])


#### Step2 - Extract only the measurements on the mean and standard deviation for each measurement ####

# Selecting subject, activity code, mean and std variables
df_1 <- df %>% 
  select(Subject, Code, contains(c("mean", "std")))


#### Step3 - Uses descriptive activity names to name the activities in the data set ####

# Join the merge table with the activities table, drop code and keep activity as a factor
df_activity <- df_1 %>% 
  left_join(activities, by = "Code") %>%
  mutate(Activity = factor(Activity, levels = activities$Activity)) %>% 
  relocate(Activity, .after = Subject) %>% 
  select(-Code)
rm(list = ls()[!grepl("df_activity", ls())])


#### Step4 - Appropriately labels the data set with descriptive variable names ####

# Fix the names of the dataframe
nick <- names(df_activity)
nick <- gsub("Freq", "Frequency", nick)
nick <- gsub("^t", "Time", nick)
nick <- gsub("^f", "Frequency", nick)
nick <- gsub("\\(\\)", "", nick)
nick <- gsub("mean", "Mean", nick)
nick <- gsub("std", "STD", nick)
nick <- gsub("BodyBody", "Body", nick)
nick <- gsub("Acc", "Accelerometer", nick)
nick <- gsub("Gyro", "Gyroscope", nick)
nick <- gsub("Mag", "Magnitude", nick)
nick <- gsub("angle", "Angle", nick)
nick <- gsub("\\(tBo", "\\(TimeBo", nick)

# Set the dataframe columns names
names(df_activity) <- nick
rm(nick)


#### Step5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject ####

# Using summarise_all from dplyr, since there is no missing values we dont specify na.rm
tidy_data <- df_activity %>% 
  group_by(Subject, Activity) %>% 
  summarise_all(mean) %>% 
  ungroup()

write.table(tidy_data, "tidy_data_final.txt", row.names = FALSE)
rm(list = ls())
