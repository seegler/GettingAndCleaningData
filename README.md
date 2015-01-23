Getting and Cleaning Data - Project Work
=========================================

Introduction
------------
This repository contains the project files for the Coursera course "Getting and Cleaning data".

Downloaded Raw Data
-------------------

Data is divided into two sets of files, training and test.
X_train.txt and X_test.txt have 561 columns of various feature variables
y_train.txt and and y_test.txt have activity label for each observation
subject_train.txt and subject_test.txt have the subject label for each observation
features.txt contains the feature labels of 561 feature variables

R Script
-------------------------------------

As required by the course project, the run_analysis.R does the following

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

    
Code Book
-------------------
The CodeBook.md file explains the final tidy data set and the transformations performed to generate it.

