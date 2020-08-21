rm(list = ls())

library(dplyr)

filename <- "Coursera_DS3_Final.zip"

if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) }

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")


#Q1 - Merge the training and the test sets to create one data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
data <- cbind(subject, Y, X)


#Q2 - Extract only the measurements on the mean and standard deviation for each measurement.
dataQ2 <- data %>% select(subject, code, contains("mean"), contains("std"))


#Q3 - Uses descriptive activity names to name the activities in the data set
dataQ2$code <- activities[dataQ2$code, 2]


#Q4 - Appropriately label the data set with descriptive variable names
names(dataQ2)[2] = "activity"
names(dataQ2)<-gsub("Acc", "Accelerometer", names(dataQ2))
names(dataQ2)<-gsub("Gyro", "Gyroscope", names(dataQ2))
names(dataQ2)<-gsub("BodyBody", "Body", names(dataQ2))
names(dataQ2)<-gsub("Mag", "Magnitude", names(dataQ2))
names(dataQ2)<-gsub("^t", "Time", names(dataQ2))
names(dataQ2)<-gsub("^f", "Frequency", names(dataQ2))
names(dataQ2)<-gsub("tBody", "TimeBody", names(dataQ2))
names(dataQ2)<-gsub("-mean()", "Mean", names(dataQ2), ignore.case = TRUE)
names(dataQ2)<-gsub("-std()", "STD", names(dataQ2), ignore.case = TRUE)
names(dataQ2)<-gsub("-freq()", "Frequency", names(dataQ2), ignore.case = TRUE)
names(dataQ2)<-gsub("angle", "Angle", names(dataQ2))
names(dataQ2)<-gsub("gravity", "Gravity", names(dataQ2))


#Q5 - From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject
FinalData <- dataQ2 %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)


str(FinalData)
View(FinalData)







