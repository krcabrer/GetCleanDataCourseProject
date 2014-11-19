#------------------------------------------------------------------------------#
# Getting and Cleaning Data
# Course Project
# By Kenneth Cabrera
#------------------------------------------------------------------------------#

# Set path constants according to the .zip structure of the data.
path <- "UCI HAR Dataset" 
pathTrain <- "train"
pathTest <- "test"

# Read the main files that contains the activity labels and the 
# names of the features 
activityLabels <- read.table(paste(".",path,"activity_labels.txt",sep="/"))
features <- read.table(paste(".",path,"features.txt",sep="/"))

# Read de data of the test set.
subj_test <- read.table(paste(".",path,pathTest,"subject_test.txt",sep="/"))
X_test <- read.table(paste(".",path,pathTest,"X_test.txt",sep="/"))
y_test <- read.table(paste(".",path,pathTest,"y_test.txt",sep="/"))

# Read de data of the train set. 
subj_train <- read.table(paste(".",path,pathTrain,"subject_train.txt",sep="/"))
X_train <- read.table(paste(".",path,pathTrain,"X_train.txt",sep="/"))
y_train <- read.table(paste(".",path,pathTrain,"y_train.txt",sep="/"))

#------------------------------------------------------------------------------#
# 1. Merges the training and the test sets to create one data set.
#------------------------------------------------------------------------------#
# Combine the whole data for the train set.
X_trainT <- cbind(subject = subj_train$V1, activity = y_train$V1, X_train)
# Combine the whole data for the test set.
X_testT  <- cbind(subject = subj_test$V1,  activity = y_test$V1,  X_test )

# Combine the train set and the test set to a unifiy set.
HumActDta <- rbind(X_trainT,X_testT)

# Take the variable names and change them to be a valid variable name in R.
varNames <- gsub("[()]","",features$V2)
varNames <- gsub("[,-]","_",varNames)

# Set the names of this variables to the whole dataset.
names(HumActDta)[1:(length(varNames))+2] <- varNames

# The activity names to lower case (are easier to read)
labelActivity <- tolower(as.character(activityLabels$V2))

# Function that change the first letter of each word in upcase.
# A slight modification of the same function in help(tolower) example.
.simpleCap <- function(x) {
  s <- strsplit(x, "[_ ]")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = " ")
}

# Appling this function to the label for the activities.
labelActivity <- as.vector(sapply(labelActivity,.simpleCap))

# Put the labels to the activity in a factor variable.
HumActDta$activity <- factor(HumActDta$activity,
                           labels = labelActivity) 

# Show three records of this unify dataset.
head(HumActDta,3)

#------------------------------------------------------------------------------#
# 2. Extracts only the measurements on the mean and 
# standard deviation for each measurement. 
#------------------------------------------------------------------------------#
require(stringr)
# Select only variables with mean() and std() strings.
# If a variable do not have both mean() and std() is because
# are variables that are maybe derivated not raw original data.
selectVars <- c(TRUE,TRUE,str_detect(features$V2,"mean\\(\\)|std\\(\\)"))
HumActDtaSelected <- HumActDta[selectVars]

require(reshape2)
# Making a tidy data with the selected dataset.
HumActDtaTidy <- melt(HumActDtaSelected,c("subject","activity"))
# Separate the variable name form the type of data (mean or std)
HumActDtaTidy$typeVar <- factor(str_extract(HumActDtaTidy$variable,"mean|std"))
HumActDtaTidy$VarName <- factor(str_replace(HumActDtaTidy$variable,"_mean_|_std_|_std|_mean",""))
# Delete the column variable to make a tidy data.
HumActDtaTidy["variable"]<-NULL

# Summary of the HumAcitivyTidy data that have only the mean and standard 
# deviation for each measurement.

summary(HumActDtaTidy)
#------------------------------------------------------------------------------#
# 3. Uses descriptive activity names to name the activities in the data set
#------------------------------------------------------------------------------#

# In this case I choose to use the same names, just the first letter in upper
# case as I already did.
levels(HumActDtaTidy$activity)

#------------------------------------------------------------------------------#
# 4.Appropriately labels the data set with descriptive variable names. 
#------------------------------------------------------------------------------#
# In this case I choose to use the following names for tha variables:
# subject: ID of the subject in the research.
# activity: Label of the activity.
# value: Value of the variable taking.
# typeVar: A variable to diferenciate between mean or std.
# VarName: Name of the taken variable.
names(HumActDtaTidy)

#------------------------------------------------------------------------------#
# 5. From the data set in step 4, creates a second, 
# independent tidy data set with the average of 
# each variable for each activity and each subject.
#------------------------------------------------------------------------------#

# Select only the mean type of variable.
HumActDtaTidy2 <- droplevels(subset(HumActDtaTidy, typeVar=="mean"))
# Delete the typeVar (Not needed any more)
HumActDtaTidy2$typeVar <- NULL
head(HumActDtaTidy2)

# Now summarize the dataset to an average of each variable,
# and each activity and each subject.
HumActDtaTidy3 <- dcast(HumActDtaTidy2, subject + activity ~ VarName, mean)

# Export the data set
write.table(HumActDtaTidy3,"HumanActivityDataSumarize.txt",row.names=FALSE)

