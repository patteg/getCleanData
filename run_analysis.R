# run_analysis.R 
# scrubs and builds tidy data set from smartphone accelerometers

library(plyr)

# 1. load the data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")
features <- read.table("./UCI HAR Dataset/features.txt", quote="\"")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"")

# 2. append the data sets into new variables
x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)
subj <- rbind(subject_test,subject_train)

# 3. identify mean and std columns; extract columns to new variable ds
stdMeanCols <-features[grep(c('mean()'), features$V2, fixed=TRUE),]
stdMeanCols <- rbind(stdMeanCols, features[grep(c('std()'), features$V2, fixed=TRUE),])

# 4. clean up the features vector and activity labels vector
stdMeanCols$V2 <- gsub('-','', stdMeanCols$V2)
stdMeanCols$V2 <- gsub('\\(\\)','', stdMeanCols$V2)
stdMeanCols$V2 <- gsub(',','', stdMeanCols$V2)
stdMeanCols$V2 <- gsub('mean','Mean', stdMeanCols$V2)
stdMeanCols$V2 <- gsub('std','Std', stdMeanCols$V2)
activity_labels$V2 <- tolower(gsub('_','',activity_labels$V2))


# 5. create dataset with all mean and std related columns 
#    apply scrubbed data column headings
#    create scrubbed data set
ds <- x[,c(stdMeanCols[,1])]
colnames(ds)[1:length(ds)] <- stdMeanCols[,2]
ds2 <- cbind(subj,y, ds)
colnames(ds2)[1]<-'subject'
colnames(ds2)[2]<-'activity'
# replace numeric activity field with descriptive data
ds3<- merge(ds2, activity_labels, by.x='activity', by.y='V1') 
ds4<- ds3[, c(2,length(ds3), 3:(length(ds3)-1))]
colnames(ds4)[2]<-'activity'
ds4<- ds4 [with(ds4, order(subject, activity)),]
write.table(ds4,'./scrubbed_data_set.txt')

# 6. create tidy data set
#    calculate mean of all measurments, group by subject and activity
tds<-ddply(ds4, c('subject','activity'), numcolwise(mean))
write.table(tds,'./tidy_data_set.txt')
