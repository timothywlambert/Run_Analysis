#############
#Merge Test and Training Data
#############

library(dplyr)

#Get test data
x_test <- read.table(paste0(getwd(), "/UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste0(getwd(), "/UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt"))
subject_test <- read.table(paste0(getwd(), "/UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"))

#Get train data
x_train <- read.table(paste0(getwd(), "/UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste0(getwd(), "/UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt"))
subject_train <- read.table(paste0(getwd(), "/UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"))

#Combine data
x_data <- rbind(x_train,x_test)
y_data <- rbind(y_train,y_test)
subject_data <- rbind(subject_train, subject_test)

#Get and Assign Column Names
features <- read.table(paste0(getwd(), "/UCI HAR Dataset/UCI HAR Dataset/features.txt"))

colnames(x_data) <- features$V2
colnames(y_data) <- "Activity"
colnames(subject_data) <- "Subject"

combined_data <- cbind(x_data, y_data, subject_data)

############
#Extract mean and std columns into a data frame
############

#Create logical vector for column names containing mean and std
mean_sd_data <- (grepl("mean..", colnames(combined_data))|
                   grepl("std..", colnames(combined_data))|
                   grepl("Activity", colnames(combined_data))|
                   grepl("Subject", colnames(combined_data))) 

#Use logical vector to subset the combined_data dataframe
mean_sd_data <- combined_data[, mean_sd_data == TRUE]

###########
#Create a Tidy Data Frame with mean and std by Activity and Subject
###########

tidy_data_activity <- mean_sd_data %>%
  group_by(Activity) %>%
  summarise_all(mean)

tidy_data_subject <- mean_sd_data %>%
  group_by(Subject) %>%
  summarise_all(mean)

#Export as txt
write.table(tidy_data_activity, paste0(getwd(), "/tidy activity data.txt"))
write.table(tidy_data_subject, paste0(getwd(), "/tidy subject data.txt"))
