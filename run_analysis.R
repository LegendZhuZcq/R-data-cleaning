#Final Project
# loading the library required
library("data.table")
library("reshape2")

#loading the data lables and descriptions, only take the second col
activityLables <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
#getting the mean and stddev for each measurement
features_mean_std <- grepl("mean|std",features)

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(X_test) = features
X_test <- X_test[,features_mean_std]

Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
Y_test[,2] = activityLables[Y_test[,1]]
names(Y_test) = c("activity_ID", "activity_label")



subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) = "subject"
#merge the test data

test_data <- cbind(as.data.table(subject_test),X_test, Y_test)

#####################
#  train     data   #
#####################

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(X_train) = features
X_train <- X_train[,features_mean_std]

Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
Y_train[,2] = activityLables[Y_train[,1]]
names(Y_train) = c("activity_ID", "activity_label")


subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) = "subject"
#merge the train data
train_data <- cbind(as.data.table(subject_train),X_train, Y_train)

#Merge the train and test data
combined_Data <- rbind(test_data,train_data)
id_label =  c("subject","activity_label","activity_ID")
data_lables = setdiff(colnames(combined_Data), id_label)
melt_combined_data = melt(combined_Data, id = id_label, measures.vars = data_lables)

tidy_data = dcast(melt_combined_data, subject + activity_label ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt")


