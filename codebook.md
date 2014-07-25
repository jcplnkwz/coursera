In the original dataset ( [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)), files containing the informations we need are:

- 'features.txt': List of all 561 features

- 'activity\_labels.txt': Links the class labels with their activity name

- 'train/X\_test.txt': The actual observations for the test set

- 'train/X\_train.txt': The actual observations for the train set

- 'test/y\_test.txt': 2 columns, observations for test set and ActivityId

- 'test/y\_train.txt': 2 columns, observations for train set and ActivityId

- 'train/subject\_test.txt': Each row identifies the subject who performed the activity. Its range is from 1 to 30.

- 'train/subject\_train.txt': Each row identifies the subject who performed the activity. Its range is from 1 to 30.

Note:

Activity labels are :

1. WALKING  
2. WALKING\_UPSTAIRS   
3. WALKING\_DOWNSTAIRS  
4. SITTING  
5. STANDING  
6. LAYING

The run\_analysis script performes the following steps:

- Merges the training and the test sets to create one data set (10299 by 564).

- Uses descriptive activity names to name the activities in the data set (using activity\_labels.txt)

- Extracts only the measurements on the mean and standard deviation for each measurement (66 features).

- Rename variables to clean illegal characters and make them more expressive.

- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.



Variables in this tidy 180 by 66 dataset are:

| [1] "PersonId" | "ActivityName" | "ActivityId" |
| --- | --- | --- |
| [4] "tBodyAcc-meanXDirection" | "tBodyAcc-meanYDirection" | "tBodyAcc-meanZDirection"  |
| [7] "tBodyAcc-StDeviationXDirection" | "tBodyAcc-StDeviationYDirection" | "tBodyAcc-StDeviationZDirection" |
| [10] "tGravityAcc-meanXDirection" | "tGravityAcc-meanYDirection" | "tGravityAcc-meanZDirection" |
| [13] "tGravityAcc-StDeviationXDirection" | "tGravityAcc-StDeviationYDirection" | "tGravityAcc-StDeviationZDirection" |
| [16] "tBodyAccJerk-meanXDirection" | "tBodyAccJerk-meanYDirection" | "tBodyAccJerk-meanZDirection" |
| [19] "tBodyAccJerk-StDeviationXDirection" | "tBodyAccJerk-StDeviationYDirection" | "tBodyAccJerk-StDeviationZDirection" |
| [22] "tBodyGyro-meanXDirection" | "tBodyGyro-meanYDirection" | "tBodyGyro-meanZDirection" |
| [25] "tBodyGyro-StDeviationXDirection" | "tBodyGyro-StDeviationYDirection" | "tBodyGyro-StDeviationZDirection" |
| [28] "tBodyGyroJerk-meanXDirection" | "tBodyGyroJerk-meanYDirection" | "tBodyGyroJerk-meanZDirection" |
| [31] "tBodyGyroJerk-StDeviationXDirection" | "tBodyGyroJerk-StDeviationYDirection" | "tBodyGyroJerk-StDeviationZDirection" |
| [34] "tBodyAccMag-mean" | "tBodyAccMag-StDeviation" | "tGravityAccMag-mean" |
| [37] "tGravityAccMag-StDeviation" | "tBodyAccJerkMag-mean" | "tBodyAccJerkMag-StDeviation" |
| [40] "tBodyGyroMag-mean" | "tBodyGyroMag-StDeviation" | "tBodyGyroJerkMag-mean" |
| [43] "tBodyGyroJerkMag-StDeviation"  | "fBodyAcc-meanXDirection" | "fBodyAcc-meanYDirection" |
| [46] "fBodyAcc-meanZDirection" | "fBodyAcc-StDeviationXDirection" | "fBodyAcc-StDeviationYDirection" |
| [49] "fBodyAcc-StDeviationZDirection" | "fBodyAccJerk-meanXDirection" | "fBodyAccJerk-meanYDirection" |
| [52] "fBodyAccJerk-meanZDirection" | "fBodyAccJerk-StDeviationXDirection" | "fBodyAccJerk-StDeviationYDirection" |
| [55] "fBodyAccJerk-StDeviationZDirection" | "fBodyGyro-meanXDirection" | "fBodyGyro-meanYDirection" |
| [58] "fBodyGyro-meanZDirection" | "fBodyGyro-StDeviationXDirection" | "fBodyGyro-StDeviationYDirection" |
| [61] "fBodyGyro-StDeviationZDirection" | "fBodyAccMag-mean"  | "fBodyAccMag-StDeviation" |
| [64] "fBodyBodyAccJerkMag-mean" | "fBodyBodyAccJerkMag-StDeviation" | fBodyBodyGyroMag-mean" |





Where prefixes 't' and 'f' mean time domain and frequency domain, respectively. 'StDeviation' stands for standard deviation.



Variables [4]-[66] are numbers, normalized between -1 and 1, as from the original data.

Activity names are character strings.

Each row of the tidy dataset (180\*66) contains the average of each variable for each activity and each subject (so there will be 30\*6=180 lines).

A step by step interpretation of the code can be found as comment in run\_analysis.R

## Transformations on data

Turn 'features' into a row vector and rename x\_test columns.

Join subject (subject\_test) and activity\_labels.

Join the resulting dataframe with features observations (x\_test).

Make descriptive names for first and second columns (PersonId and ActivityId).

Append a column at the end with descriptive names for Activities.

Repeat the process for Train Data.

Merge the Test and Train Data.

Select required features: those with "\*-mean\\(\\)|-std\*" pattern.

Subset merged data frame selecting only columns corresponding to required features (mean and std).

Create a 10299 by 69 data frame with PersonId, ActivityId, ActivityName and the 66 mean and standard deviation features.

Change feature names according to these patterns:

"()-X" → "XDirection"  "()-Y" → "YDirection"   "()-Z" → "ZDirection"  "mean\\(\\)" → "mean"

"std\\(\\)" → "StDeviation"

Create the 180\*66 data frame with ddply on PersonId and ActivityName.