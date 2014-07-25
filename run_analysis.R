setwd("C:/")


if (!file.exists("data")){
  dir.create("data")
}

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="C:/data/courseproject.zip")

setwd("C:/data")
unzip("C:/data/courseproject.zip")




#read data from files


features<-read.table("C:/data/UCI HAR Dataset/features.txt")
xtest<-read.table("C:/data/UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("C:/data/UCI HAR Dataset/test/y_test.txt")
subjecttest<-read.table("C:/data/UCI HAR Dataset/test/subject_test.txt")
activitylabels<-read.table("C:/data/UCI HAR Dataset/activity_labels.txt")


features_tr<-t(as.matrix(features$V2))          #makes a row vector
col_headings<-c(features_tr[1:561])      
names(xtest)<-col_headings                      #change column names in xtest data frame

test_comb1<-cbind(subjecttest,ytest)    #join Person ID and Activity
test_comb2<-cbind(test_comb1, xtest)    #join with features observations

colnames(test_comb2)[c(1,2)] <- c("PersonId", "ActivityId")       #make descriptive names for first and second columns

test_comb2$ActivityName <- ordered(test_comb2$ActivityId,levels = c(1,2,3,4,5,6), labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))  # Append a column at the end with descriptive names for Activities

################################################################

#Repeat the process for Train Data


xtrain<-read.table("C:/data/UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("C:/data/UCI HAR Dataset/train/y_train.txt")
subjecttrain<-read.table("C:/data/UCI HAR Dataset/train/subject_train.txt")

names(xtrain)<-col_headings

train_comb1<-cbind(subjecttrain,ytrain)
train_comb2<-cbind(train_comb1, xtrain)

colnames(train_comb2)[c(1,2)] <- c("PersonId", "ActivityId")

train_comb2$ActivityName <- ordered(train_comb2$ActivityId,levels = c(1,2,3,4,5,6), labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

#######################################


#Merge the Test and Train Data


testntrain<-rbind(test_comb2,train_comb2)  


########################################


tidyfeatures <- grep("*-mean\\(\\)|-std*", features[,2])     #select required features  (selected features)


tidyfeatures<-tidyfeatures+2  #take into account the structure of merged data frame

tidytestntrain<-testntrain[,tidyfeatures]  #select the requested columns (mean and standard deviation) in testntrain data frame


subtestntrain<-testntrain[,c(1,2,564)]   #create a 3 columns data frame from testntrain with PersonId, ActivityId and ActivityName

tidy1<-cbind(subtestntrain,tidytestntrain) #create a first tidy 10299 by 69 data frame with PersonId, ActivityId, ActivityName and the 66 mean and standard deviation features

#####################################################################################

tidynames<-names(tidy1)
i1<-gsub("()-X","XDirection", tidynames[1:66])
i2<-gsub("()-Y","YDirection", i1)
i3<-gsub("()-Z","ZDirection", i2)
i4<-gsub("mean\\(\\)","mean", i3)
names<-gsub("std\\(\\)","StDeviation", i4)
colnames(tidy1)[4:69] <- names[1:66]

######################################################################################

library("plyr")

tidy2<-ddply(tidy1, c("PersonId", "ActivityName"), numcolwise(mean))  # create the second tidy data frame (dim=180*69), "plyr" package required.

dim(tidy2)
