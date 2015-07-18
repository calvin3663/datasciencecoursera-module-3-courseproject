---
title: "CodeBook for 'run_analysis.R'"
author: "Calvin Chin"
date: "July 18, 2015"
output: html_document
---

### Introduction

The objective of the 'run_analysis.R' script is to prepare tidy data by extracting and merging the data sets obtained from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


After reading the source data files, the script then does the following:

* Combined the 'subject', 'X' and 'y' files from the 'train' and 'test' directory into 'train' and 'test' data sets
* Appropriately labels the 'train' and 'test' data set with descriptive column names obtained from the 'features.txt' file
* Creates a single data set by merging the 'train' and 'test' data sets 
* Change value of the 'activity' column by mapping the value against the descriptive activity names obtained from the 'activity_labels.txt' file
* Extracts the columns that contains the mean and standard deviation measurements (i.e. column names with 'mean()' or 'std()')
* Creates a summary data set with the average of each variable, group by each activity and subject.

Finally, the summary data set is written onto a file **'summary.txt'**


******
### Initialize the environment

Ensures that 'plyr' and 'dlyr' libraries required to run the script is available.

```{r}
if (require(plyr) == FALSE) {
  stop("Unable to load 'plyr' package that's required to run the script!")
}

if (require(dplyr) == FALSE) {
  stop("Unable to load 'dplyr' package that's required to run the script!")
}
```

Initialize path variables according to how the source data files are stored.

**NOTE:** The R Script assumes source data is downloaded and Unzip into the "./UCI HAR Dataset/" directory.

```{r}
label_data_path <- "./UCI HAR Dataset/"
train_data_path <- "./UCI HAR Dataset/train/"
test_data_path <- "./UCI HAR Dataset/test/"
```

### Read label files

```{r}
# Read 'activity_labels.txt'
filename <- paste(label_data_path, "activity_labels.txt", sep = "")
df_activity_labels <- read.table(file = filename, header = FALSE)

# Read 'features.txt'
filename <- paste(label_data_path, "features.txt", sep = "")
df_feature_labels <- read.table(file = filename, header = FALSE)
```

### Read and combine files in the 'train' directory

```{r}
# Read 'subject_train.txt'
filename <- paste(train_data_path, "subject_train.txt", sep = "")
df_subject_train <- read.table(file = filename, header = FALSE)
colnames(df_subject_train) <- c("subject") 

# Read 'X_train.txt'
filename <- paste(train_data_path, "X_train.txt", sep = "")
df_x_train <- read.table(file = filename, header = FALSE)
colnames(df_x_train) <- as.character(df_feature_labels[,2])

# Read 'y_train.txt'
filename <- paste(train_data_path, "y_train.txt", sep = "")
df_y_train <- read.table(file = filename, header = FALSE)
colnames(df_y_train) <- c("activity")

# Merge subject_train, x_train & y_train into one single Data Frame
df_train <- cbind(df_subject_train, df_y_train, df_x_train)
```

### Read and combine files in the 'test' directory

```{r}
# Read 'subject_test.txt'
filename <- paste(test_data_path, "subject_test.txt", sep = "")
df_subject_test <- read.table(file = filename, header = FALSE)
colnames(df_subject_test) <- c("subject")

# Read 'X_test.txt'
filename <- paste(test_data_path, "X_test.txt", sep = "")
df_x_test <- read.table(file = filename, header = FALSE)
colnames(df_x_test) <- as.character(df_feature_labels[,2])

# Read 'y_test.txt'
filename <- paste(test_data_path, "y_test.txt", sep = "")
df_y_test <- read.table(file = filename, header = FALSE)
colnames(df_y_test) <- c("activity")

# Merge subject_test, x_test & y_test into one single Data Frame
df_test <- cbind(df_subject_test, df_y_test, df_x_test)
```

### Create a single data set 'df_combined'

```{r}
df_combined <- rbind(df_train, df_test)
```

### Change the value of the 'activity' column to descriptive names

```{r}
df_combined$activity <- mapvalues(
                            df_combined$activity, 
                            from = df_activity_labels[,1], 
                            to = as.character(df_activity_labels[,2])
                        )
```

### Extracts the columns that contains the mean and standard deviation

```{r}
fieldnames <- c("subject", "activity", 
                    grep("mean()", names(df_combined), value = TRUE, fixed = TRUE), 
                    grep("std()", names(df_combined), value = TRUE, fixed = TRUE)
                )
df_mean_std_only <- df_combined[, fieldnames]
```

### Creates a summary data set with the average of each variable.

```{r}
df_summary <- df_mean_std_only %>%
                  group_by(activity, subject) %>%
                      summarise_each(funs(mean))

```

# Write summary data to file: summary.txt

```{r}
write.table(df_summary, file = 'summary.txt', row.names = FALSE, col.names = TRUE)
```





