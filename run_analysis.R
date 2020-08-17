# Downloading the data and saving it

library(plyr)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

# Unzip the file

unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Saving the data in the folder

path_rf <- file.path("./data" , "UCI HAR Dataset")
files <- list.files(path_rf, recursive=TRUE)

# Read data from files
# Read the "Activity files"

data_activitytest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
data_activitytrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

# Read the "Subject files"

data_subjecttrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
data_subjecttest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

# Read "Features files"

data_featurestest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
data_featurestrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

# Merging data sets
# Concatenate by rows 

data_subject <- rbind(data_subjecttrain, data_subjecttest)
data_activity<- rbind(data_activitytrain, data_activitytest)
data_features<- rbind(data_featurestrain, data_featurestest)

# Set names to variables

names(data_subject)<-c("subject")
names(data_activity)<- c("activity")
data_featuresnames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(data_features)<- data_featuresnames$V2

# Merge columns 

data_combine <- cbind(data_subject, data_activity)
Data_set <- cbind(data_features, data_combine)

# Extracts  mean and standard deviation 

subdata_featuresnames <-data_featuresnames$V2[grep("mean\\(\\)|std\\(\\)", data_featuresnames$V2)]

# Subset the data frame "Data" by names of Features

selected_names <-c(as.character(subdata_featuresnames), "subject", "activity" )
Data_set <-subset(Data_set,select=selected_names)

# Uses descriptive activity names

activity_labels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

# factorize variable "activity" 

Data_set$activity <- factor(Data_set$activity);
Data_set$activity <- factor(Data_set$activity,labels=as.character(activity_labels$V2))

# Labels of the data set

names(Data_set) <- gsub("^t", "time", names(Data_set))
names(Data_set) <- gsub("^f", "frequency", names(Data_set))
names(Data_set) <- gsub("Acc", "Accelerometer", names(Data_set))
names(Data_set) <- gsub("Gyro", "Gyroscope", names(Data_set))
names(Data_set) <- gsub("Mag", "Magnitude", names(Data_set))
names(Data_set) <- gsub("BodyBody", "Body", names(Data_set))

# Creation of final data set

Final_data <- aggregate(. ~subject + activity, Data_set, mean)
Final_data <- Final_data[order(Final_data$subject,Final_data$activity),]
write.table(Final_data, file = "final_dataset.txt",row.name=FALSE)
