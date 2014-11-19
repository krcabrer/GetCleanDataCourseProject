Human Activity recordered by a smartphone
=========================

### Getting and Cleaning Data Course Project

The file `run_analysis.R` is the code for run to obtain the data as an answer to the questions of the project.

The code starts settings some paths where the data is located.

It works in any location, just is the way you obtain the tree strucutre as you unzip the data zip file.

Then it read all the data, in separate files, with the same names of the original data.

----

Then you can see that each section answer each question.

The code is documented where you can find the explanation of each command.

```
#------------------------------------------------------------------------------#
# 1. Merges the training and the test sets to create one data set.
#------------------------------------------------------------------------------#
```

```
#------------------------------------------------------------------------------#
# 2. Extracts only the measurements on the mean and 
# standard deviation for each measurement. 
#------------------------------------------------------------------------------#
```

```
#------------------------------------------------------------------------------#
# 3. Uses descriptive activity names to name the activities in the data set
#------------------------------------------------------------------------------#
```

```
#------------------------------------------------------------------------------#
# 4.Appropriately labels the data set with descriptive variable names. 
#------------------------------------------------------------------------------#
```

```
#------------------------------------------------------------------------------#
# 5. From the data set in step 4, creates a second, 
# independent tidy data set with the average of 
# each variable for each activity and each subject.
#------------------------------------------------------------------------------#
```

----

### List of variables in the tidy data

- subject: Id of the suject in the experiment.
- activity: Label of the activity (Walking,Walking Upstairs,Walking Downstairs,Sitting,Standing,Laying).

The main variables are:

- BodyAccJerk
- BodyAccMag
- BodyAcc
- BodyBodyAccJerkMag
- BodyBodyGyroJerkMag
- BodyBodyGyroMag
- BodyGyro

As the original documentation says:

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals.

Again it says:

>the acceleration signal was then separated into body and gravity acceleration signals.

But as the README file says:

>Features are normalized and bounded within [-1,1].

So all values are dimensionless, asociated with acceleration signals and gyriscope 3-axial signals.


In this case the following are 3D thats the reason the have an X, Y and Z values.

- BodyAccJerk
- BodyAcc
- BodyGyro

All variables are in two group that starts with *t* or *f*, meaning that comes from time or frequency domain.

The variables with Mag sufix mean that is a 3D magnitud of the variable.

- BodyAccMag
- BodyBodyAccJerkMag
- BodyBodyGyroJerkMag
- BodyBodyGyroMag
