# Ensure that libraries required to run this script is loaded
if (require(plyr) == FALSE) {
  stop("Unable to load 'plyr' package that's required to run the script!")
}

if (require(dplyr) == FALSE) {
  stop("Unable to load 'dplyr' package that's required to run the script!")
}



# Assuming that the required source data files are downloaded and unzip to "./UCI HAR Dataset"
label_data_path <- "./UCI HAR Dataset/"
train_data_path <- "./UCI HAR Dataset/train/"
test_data_path <- "./UCI HAR Dataset/test/"

# Read 'activity_labels.txt'
filename <- paste(label_data_path, "activity_labels.txt", sep = "")
df_activity_labels <- read.table(file = filename, header = FALSE)

# Read 'features.txt'
filename <- paste(label_data_path, "features.txt", sep = "")
df_feature_labels <- read.table(file = filename, header = FALSE)


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


# Merges the training (df_train) and  test (df_test) to create one data set (df_combined)
df_combined <- rbind(df_train, df_test)

# Change the values of the 'activity' column to use descriptive activity names by mapping the values from df_activity_labels
df_combined$activity <- mapvalues(
                          df_combined$activity, 
                          from = df_activity_labels[,1], 
                          to = as.character(df_activity_labels[,2])
                        )

# Extracts only the columns with measurements on the mean and standard deviation, i.e. column names contain "mean()" or "std()"
fieldnames <- c("subject", "activity", 
                    grep("mean()", names(df_combined), value = TRUE, fixed = TRUE), 
                    grep("std()", names(df_combined), value = TRUE, fixed = TRUE)
                )
df_mean_std_only <- df_combined[, fieldnames]

# creates a tidy data set with the average of each variable for each activity and each subject
df_summary <- df_mean_std_only %>%
                  group_by(activity, subject) %>%
                      summarise_each(funs(mean))

# Write summary data to file: summary.txt
write.table(df_summary, file = 'summary.txt', row.names = FALSE, col.names = TRUE)
