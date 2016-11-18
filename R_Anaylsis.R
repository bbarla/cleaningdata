library(reshape2)

# Load activity labels + features
activityLabels <- read.table("/home/bbarla/datascience/cleaningdata/UCI HAR Dataset/activity_labels.txt")
activityLabels
activityLabels[,2] <- as.character(activityLabels[,2])
activityLabels[,2]
features <- read.table("/home/bbarla/datascience/cleaningdata/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


# Load the datasets
train <- read.table("/home/bbarla/datascience/cleaningdata/UCI HAR Dataset/train/X_train.txt")[featuresWanted]
head(train,10)
trainActivities <- read.table("/home/bbarla/datascience/cleaningdata/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("/home/bbarla/datascience/cleaningdata/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("/home/bbarla/datascience/cleaningdata/UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("/home/bbarla/datascience/cleaningdata/UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("/home/bbarla/datascience/cleaningdata/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
allData <- rbind(train, test)

colnames(allData) <- c("subject", "activity", featuresWanted.names)
head(allData,2)