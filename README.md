---
title: "README"
author: "Calvin Chin"
date: "July 18, 2015"
output: html_document
---

### Introduction

The objective of the **'run_analysis.R'** script is to prepare tidy data by extracting and merging the data sets obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The source data from the link above represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


After reading the source data files, the script then does the following:

* Combined the 'subject', 'X' and 'y' files from the 'train' and 'test' directory into 'train' and 'test' data sets
* Appropriately labels the 'train' and 'test' data set with descriptive column names obtained from the 'features.txt' file
* Creates a single data set by merging the 'train' and 'test' data sets 
* Change value of the 'activity' column by mapping the value against the descriptive activity names obtained from the 'activity_labels.txt' file
* Extracts the columns that contains the mean and standard deviation measurements (i.e. column names with 'mean()' or 'std()')
* Creates a summary data set with the average of each variable, group by each activity and subject.

Finally, the summary data set is written onto a file **'summary.txt'**


For more information about how the script works, kindly refer to the **'CodeBook.md'** file.


******
### How to Run the Script

**Step 1:** Download the R Script file **'run_analysis.R'** onto your working directory

**Step 2:** Download source data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Extract the zip file into your working directory.

**Step 3:** Make sure your R environment has **'plyr'** and **'dplyr'** libraries installed. If not, use **install.packages()** to install the required libraries.

**Step 4:** Run the script from your R Console by issuing the command: **source("run_analysis.R")**




