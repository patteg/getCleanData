The following steps outline data retrieval, scrubbing process and assumptions made to obtain the summarized data set 'tidy_data_set.txt':

1. Data is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. The unzipped file contains folder with the following subfolders and files
 a) ./test/
     Test set of data including
          i) subject_test.txt - numeric variable representing individual doing test
          ii) y_test.txt - numeric variable representing activity performed
          iii) x_test.txt -specific measurements per individual across a range of activities
 b) ./train/
     Trainingset of data including
          i) subject_train.txt - numeric variable representing individual doing test
          ii) y_train.txt - numeric variable representing activity performed
          iii) x_train.txt-specific measurements per individual across a range of activities
 c) ./activity_labels.txt
     A descriptive label for each activity measured 
 d) ./features_info.txt
     A summary of the group measurements including statistics, and naming conventions for 
     each field
 ./features.txt
     A list of the actual field names that describe each variable
 ./README.txt
     General introduction to the study/experiment, and files contained within the dataset.  
     This can be referred to for more details on the files documented
     
3. Each file is loaded into a seperate R variable with the same name

4. a) The raw test and train variables (x_test, x_train) are merged into a dataset x
   b) The activity variables (y_test, y_train) are merged into a dataset y
   c) The subject variables (subject_test, subject_train) are merged into a dataset subj
   
5. The features dataset is filtered for mean and standard deviation columns only (mean, std)
     as outlined in the project and placed in stdMeanCols variable.  The assumption made here is 
     that any field with mean() or std() in the name will be included.  This methods yields 66 
     related fields.

6. stdMeanCols and activity variables are scrubbed to remove commas, brackets, dashes, underscore

7.  The mean and standard deviations are extracted from the merged x variables and placed in variable ds (data structure).  From here, the data structure is built up in consecutive steps to include the participant (subject) and activity (lookup has been done back to activity labels via the merge command)

8.  The merged raw data measurements (x), participants (subj) and descriptive activity (activity)
are now merged together into one data variable ds4.  This information is exported into a data file 'scrubbed_data_set.txt'.  This file contains the entire merged set of test and training data sets related to mean and standard deviation with no adjustments to the underlying figures.  Dimensions of the scrubbed data set are 10299 rows by 68 columns.

9.  The last step is to calculate the mean of each measurement by participant (subj) and specific activity (activity).  The scrubbed data set ds4 is used for the calculation. The results are stored in the variable tds and exported to a data file 'tidy_data_set.txt'.  Dimensions of the tidy data set are 180 rows by 68 columns.