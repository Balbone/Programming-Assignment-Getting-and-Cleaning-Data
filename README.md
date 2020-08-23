The run_analysis.R file included in this repo is the solution to the final task required by the course "Getting and Cleaning Data". 

First of all, I downloaded and extracted the data set under the folder called "UCI HAR Dataset". 
I then assigned each file to a dataset:
- features.txt -> features 
- activity_labels.txt -> activities 
- subject_test.txt -> subject_test 
- subject_train.txt -> subject_train 
- x_train-txt -> x_train 
- y_train.txt -> y_train 
- x_test.txt -> x_test
- y_test.txt -> y_test 


Let's now address the 5 points required by the task:

1) Merge the training and the test sets to create one data set. 
- X -> obtained by rbind() function, merging x_train and x_test
- Y -> obtained by rbind() function, merging y_train and y_test
- subject  -> obtained by rbind() function, merging subject_train and subject_test
- data -> obtained by cbind() function, merging X, Y and subject 

2) Extract only the measurements on the mean and standard deviation for each measurement.
dataQ2 is created from data, selecting only this columns: subject, code and mean and std for each measurement. 

3) Use descriptive activity names to name the activities in the data set.
Column code was replaced by corresponding activity taken from the second column of variable activities. 

4) Appropriately label the data set with descriptive variable names. 
- code renamed in activities 
- Acc replaced by Accelerometer 
- Gyro replaced by Gyroscope 
- BodyBody replaced by Magnitude 
- All words starting with t have been replaced with Time
- All words starting with f have been replaced with Frequency
- tbody replaced by TimeBody 
- angle replaced by Angle 
- gravity replaced by Gravity 

5) From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject. 
FinalData is created from dataQ2. First of all, dataQ2 was grouped by subject and activity, then we take the means of each variable for each activity and each subject. 
Finally, FinalData was exported as FinalData.txt











