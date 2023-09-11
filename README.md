R scripts
* ***importing.R*** checks if the zip file was downloaded in the working directory, if not, it will download and make the importing of the differents files we are going to use.
  * Use a if statement to checks if the file doesnt exist to download, another if statement to check if the file was not unziped to unzip it.   And import all the .txt file we need.
* ***run_analysis.R*** do the data prepartion to follow in the project
  * Step1: Merges the training and the test sets to create one data set.  After the importation from ***importing.R***, we use rbind and cbind to merge the data.
  * Extracts only the measurements on the mean and standard deviation for each measurement. *dplyr* helps us with the select and contains functions.
  * Uses descriptive activity names to name the activities in the data set.   Used *left join* between the main merged table and the activity table then mutate to update the column Activity to a factor.
  * Appropriately labels the data set with descriptive variable names.   Regex to update the original columns names to reassign to the dataframe
  * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.   Grouped by Subject and Activity then summarize_all or summarise_all to get all variables mean. 
