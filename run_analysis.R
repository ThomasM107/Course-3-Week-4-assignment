## PART 1 - combine the data into one data frame

## Load the training data into a data frame
traindata <- read.table("train/X_train.txt")

## Load the test data into a data frame
testdata <- read.table("test/X_test.txt")

## merge the two datasets, with training data followed by test data
alldata <- merge(traindata, testdata, all = TRUE, sort = FALSE)


## PART 2 - extract the mean and standard deviation data

## Open the list of features make a vector of features containing either mean or standard deviation, but excluding meanFreq
features <- read.table("features.txt", stringsAsFactors = FALSE)
meanstd <- grep("mean\\(|std", features$V2)
meanstddata <- alldata[meanstd]

## PART 3 - label the activities


## Load the training labels into a data frame
trainlabels <- read.table("train/y_train.txt")
names(trainlabels) <- "Activity"

## Load the test labels into a data frame
testlabels <- read.table("test/y_test.txt")
names(testlabels) <- "Activity"

## Combine labels in one vector
alllabels <- rbind(trainlabels, testlabels)

## open the list of variable names
activitylabels <- read.table("activity_labels.txt")

## Replace numbers in all labels with corresponding activity from activitylabels
activity <- sapply(alllabels, function(x) x = activitylabels[x, 2])


## PART 4 - label the variables

##  Identify the retained mean and standard deviation feature labels
retfeatures <- features[meanstd, 2]

## Set all to lower case
retfeatures <- tolower(retfeatures)

## Replace abbreviations with full names
retfeatures <- sub("mean\\(\\)", "mean", retfeatures)
retfeatures <- sub("std\\(\\)", "standard_deviation", retfeatures)
retfeatures <- sub("mag", "-magnitude", retfeatures)
retfeatures <- sub("bodyacc-", "body_acceleration-", retfeatures)
retfeatures <- sub("gravityacc-", "gravity_acceleration-", retfeatures)
retfeatures <- sub("bodygyro\\-", "body_gyroscope-", retfeatures)
retfeatures <- sub("bodyaccjerk", "body_linear_acceleration", retfeatures)
retfeatures <- sub("bodygyrojerk", "body_angular_acceleration", retfeatures)
retfeatures <- sub("^t", "time_",  retfeatures)
retfeatures <- sub("^f", "frequency_",  retfeatures)
retfeatures <- sub("bodybody", "body", retfeatures)


## Part 5 - Create an independent tidy data set with the average of 
## each variable for each activity and each subject

numfeatures <- length(retfeatures)
numactivities <- nrow(activitylabels)
tidyactivitymean <- data.frame(matrix(nrow = numactivities, ncol = numfeatures))

for (i in 1:numfeatures) {
  tidydum <- tapply(meanstddata[,i], activity, mean)
  tidyactivitymean[,i] <- tidydum
}

rownames(tidyactivitymean) <- rownames(tidydum)
colnames(tidyactivitymean) <- retfeatures

## Append a label to tidysubjectmean indicating what type of average. The data
## can in future be split on type if necessary/desired
tidyactivitymean <- cbind(meantype = "activity", tidyactivitymean)

## Create data frame of averages for each subject

## Load the training subjects into a data frame
trainsubjects <- read.table("train/subject_train.txt")
names(trainsubjects) <- "Subject"

## Load the test subjects into a data frame
testsubjects <- read.table("test/subject_test.txt")
names(testsubjects) <- "Subject"

allsubjects <- merge(trainsubjects, testsubjects, by.x = "Subject", by.y = "Subject", all = TRUE, sort = FALSE)

totalsubjects <- length(unique(unlist(allsubjects)))
tidysubjectmean <- data.frame(matrix(nrow =totalsubjects, ncol = numfeatures))

for (i in 1:numfeatures) {
  tidydum2 <- tapply(meanstddata[,i], allsubjects, mean)
  tidysubjectmean[,i] <- tidydum
}

rownames(tidysubjectmean) <- sapply(rownames(tidydum2), function(x) paste0("Subject_", x))
colnames(tidysubjectmean) <- retfeatures

## Append a label to tidysubjectmean indicating what type of average. The data
## can in future be split on type if necessary/desired
tidysubjectmean <- cbind(meantype = "subject", tidysubjectmean)

## Combine the data and output to a file

combinedmeans <- rbind(tidyactivitymean, tidysubjectmean)
write.csv(combinedmeans, file = "tidytrackingdata.csv")
