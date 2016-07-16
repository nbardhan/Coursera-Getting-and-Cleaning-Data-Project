##other users have used a library to access a package of some sort, but that was not necessary for me, seeing as I already had access to the necessary functions within the package I already had

filename <- "getdata_dataset.zip"

## if not already done, this downloads and unzips the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels + features
activityLabel <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabel[,2] <- as.character(activityLabels[,2])
feature <- read.table("UCI HAR Dataset/features.txt")
feature[,2] <- as.character(features[,2])

# isolate the data to only getting the mean and standard deviation
dataDesired <- grep(".*mean.*|.*std.*", feature[,2])
dataDesired.names <- feature[dataDesired,2]
dataDesired.names = gsub('-mean', 'Mean', dataDesired.names)
dataDesired.names = gsub('-std', 'Std', dataDesired.names)
dataDesired.names <- gsub('[-()]', '', dataDesired.names)

# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[dataDesired]
trainActivity <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubject, trainActivity, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivity <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubject, testActivity, test)

# merge datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", dataDesired.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabel[,1], labels = activityLabel[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
