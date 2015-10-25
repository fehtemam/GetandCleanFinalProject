### Getting and Cleaning Data :: Course project

## Reading the data for the test set:
SubjTest <- read.table("./test/subject_test.txt")  ## subjects
Xtest <- read.table("./test/X_test.txt")           ## measurements
Ytest <- read.table("./test/y_test.txt")           ## activities
## Changing the name of columns for subjects and activities 
names(SubjTest) <- "Subj"
names(Ytest) <- "Y"
## Reading the data for the training set: 
SubjTrain <- read.table("./train/subject_train.txt")  ## subjects
Xtrain <- read.table("./train/X_train.txt")           ## measurements
Ytrain <- read.table("./train/y_train.txt")           ## activities
## Changing the name of columns for subjects and activities
names(SubjTrain) <- "Subj"
names(Ytrain) <- "Y"
## Saving the activity labels in in a data frame:
activityLabel <- read.table("./activity_labels.txt")
## Merging measurements with activities with subjects and then merging everything for test and training
testData <- cbind(Xtest, Ytest, SubjTest)      ## merged test dataset
trainData <- cbind(Xtrain, Ytrain, SubjTrain)  ## merged training dataset
allData <- rbind(testData, trainData)          ## all data merged
## Checking for NA values (just to make sure there isn't any)
sum(is.na(allData))
## Reading the name of all measurements and then extracting the ones including "mean()" and "std()"
features <- read.table("./features.txt")
## using backslash below is necessary since "()" is not regex character
col_indices <- grep("mean\\(\\)|std\\(\\)", features[,2])  ## indices of column names that contain mean() and std()              
col_names <- grep("mean\\(\\)|std\\(\\)", features[,2], value = T)  ## the actual strings for those indices extracted in the line above
## Subsetting data for columns that have "mean()" and "std()" patterns and also subject and activity columns:
subData <- allData[,c(col_indices, 562, 563)]
names(subData)[1:66] <- col_names    ## label columns with appropriate names extracted in previous step
## Replacing activity codes with appropriate activity labels:
subData$Y <- activityLabel$V2[subData$Y]
## Rearranging data so that subject and activity columns are in the beginning:
orderedData <- subData[,c(68, 67, 1:66)]
names(orderedData)[2] <- "Activity" ## Changing the name of the activity column from "Y" to "Activity"
## Loading package 'dplyr':
library(dplyr)
## Grouping data by subject and activity 
orderedData = orderedData %>% group_by(Subj, Activity)
## Making a wide format tidy dataset with average values:
tidyData <- summarize_each(orderedData, funs(mean))
## Writing the data to the output:
write.table(tidyData, file = "tidyData.txt", row.name=FALSE)


