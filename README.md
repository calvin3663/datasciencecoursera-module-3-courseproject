---
Title: "README"
Author: "Calvin Chin"
---

### Introduction

The objective of the **'run_analysis.R'** script is to prepare tidy data by extracting and merging the data sets obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The source data from the link above represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


After reading the source data files, the script then does the following:

* Create a Data Frame **[df_train]** by merging the **"subject_train.txt"**, **"X_train.txt"** and **"y_train.txt"** files from the **"train"** directory
* Similarly, create a Data Frame **[df_test]** by merging the **"subject_test.txt"**, **"X_test.txt"** and **"y_test.txt"** files from the **"test"** directory
* Appropriately labels the **[df_train]** and **[df_test]** data frames with the column names obtained from the **"features.txt"** file
* Creates a single data frame called **[df_combined]** by combining **[df_train]** and **[df_test]** 
* Change value of the **[df_combined$activity]** column by mapping the original value against the descriptive activity names obtained from the **"activity_labels.txt"** file
* Extracts the columns that contains the mean and standard deviation measurements (i.e. column names with **"mean()"** or **"std()"**)
* Creates a summary data frame **[df_summary]** with the average of the mean/std columns, group by **activity** and **subject**.
* Change the column names to be more descriptive by removing **"()"** from the column names
* Finally, the summary data set is written onto a file **"summary.txt"**


For more information about the output file **(summary.txt)**, kindly refer to the Data Dictionary file **"CodeBook.md"**.


******
### How to Run the Script

**Step 1:** Download the R Script file **"run_analysis.R"** onto your working directory

**Step 2:** Download source data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Extract the zip file into your working directory.

**Step 3:** Make sure your R environment has **"plyr"** and **"dplyr"** libraries installed. If not, use **install.packages()** to install the required libraries.

**Step 4:** Run the script from your R Console by issuing the command: **source("run_analysis.R")**



