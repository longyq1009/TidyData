## First, read all files that we need.

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Merges the training and the test sets to create one data set.

X <- rbind(X_test,X_train)
subject <- rbind(subject_test,subject_train)
y <- rbind(y_test,y_train)

## Extracts only the measurements on the mean and standard deviation
## for each measurement. 

names(X) <- features$V2
X2 <- X[,grep("mean\\(\\)|std",features$V2)]

## Uses descriptive activity names to name the activities in the data set.

activity <- as.character(y[,1]) 
y[,2] <- activity
for(i in 1:6){
        logi <- y[,1]==activity_labels[i,1]
        y[logi,2] <- as.character(activity_labels[i,2])
}
Dtdt <- cbind(subject,y[,2],X2)
names(Dtdt)[1:2] <- c("subject","activity")

## Creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject. 

s <- split(Dtdt,list(Dtdt$activity,Dtdt$subject))
sub <- lapply(s,function(s) {
        t <- s[1,]
        t[,3:68] <- colMeans(s[,3:68])
        t[,1:2] <- s[1,1:2]
        t
})
tidy_data <- sub[[1]]
for(i in 2:180){
        tidy_data <- rbind(tidy_data,sub[[i]])
}
rownames(tidy_data) <- seq(tidy_data$subject)

## output the tidy data set

write.csv(tidy_data,"./tidy_data.txt")