# Run_Analysis
Load dplyr package into R
Import all the test, train, and subject data
Using rbind function, combine the data
Import the features file and use it to generate column names in the merged data
Combine everything using cbind

Use grepl function to see which column names have mean, std, activity, or subject
Subset the data to only return columns with mean, std, activity, or subject

Use dplyr package to create new data frame based on activity and subject showing the means of all columns

Export each data frame as a txt
