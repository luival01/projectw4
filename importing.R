#### Step1 - Download dataset   ####

# Name to save the file
filename <- "JHUCDW4.zip"

# Check if the file already exist
if (!file.exists(filename)){
  url_zip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url_zip, destfile = filename)
}

# Check if the file was unziped
if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}
rm(filename)


#### Step2 - Importing files and concatenate test and train same data ####

# Takes all files in the folders
test_files <- list.files("./UCI HAR Dataset/test", pattern = "txt$", full.names = TRUE, recursive = FALSE)
train_files <- list.files("./UCI HAR Dataset/train", pattern = "txt$", full.names = TRUE, recursive = FALSE)

# Read the files
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Code", "Activity"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n", "names"))
test_sub <- read.table(test_files[1])
test_x <- read.table(test_files[2])
test_y <- read.table(test_files[3])
train_sub <- read.table(train_files[1])
train_x <- read.table(train_files[2])
train_y <- read.table(train_files[3])
rm(test_files, train_files)
