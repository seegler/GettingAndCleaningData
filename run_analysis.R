
# This script requires downloaded data to be unzipped in the current working directory of R
# X_train.txt and X_test.txt have 561 columns of various feature variables
# y_train.txt and and y_test.txt have activity label for each observation
# subject_train.txt and subject_test.txt have the subject label for each observation

# Load training data first
trainingData = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
# Load activity label of each training observation as next column
trainingData[,562] = read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
# Load subject of each training observation as next column
trainingData[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# Load testing data 
testingData = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
# Load activity label of each testing observation as next column
testingData[,562] = read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
# Load subject of each testing observation as next column
testingData[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# Load activity labels
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Load feature names
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)

# Remove special characters from feature names
features[,2] = gsub('[-()]', '', features[,2])

# Merge the training and the test sets to create one data set (total 563 columns)
mergedData = rbind(trainingData, testingData)

# Extracts only the measurements on the mean and standard deviation for each measurement

# Find columns that are either Mean or Std. Deviation
requiredCols <- grep(".*mean.*|.*std.*|.*Mean.*|.*Std.*", features[,2])

# Reduce features dat to the required columns
features <- features[requiredCols,]

# Retain Subject and Activity columns
requiredCols <- c(requiredCols, 562, 563)

# Remove the unwanted columns from merged data
mergedData <- mergedData[,requiredCols]

# Set column names (features) to merged data
colnames(mergedData) <- c(features$V2, "Activity", "Subject")

# Substitute activity number with descriptinve activity name in merged data
activityNumber = 1
for (activityLabel in activityLabels$V2) {
	mergedData$Activity <- gsub(activityNumber, activityLabel, mergedData$Activity)
	activityNumber <- activityNumber + 1
}

# Convert Subject and Activity variables to factors
mergedData$Activity <- as.factor(mergedData$Activity)
mergedData$Subject <- as.factor(mergedData$Subject)

# Find mean grouped by activity and subject and assign as tidy data
tidyData = aggregate(mergedData, by=list(Activity = mergedData$Activity, Subject=mergedData$Subject), mean)


# Remove last two columns, subject and activity column, since their mean is NA
tidyData <- tidyData[,1:(ncol(tidyData)-2)]

#Write tidy data to a text file
#Exclude row names
write.table(tidyData, "tidy_data.txt", sep="\t", row.names = FALSE)

