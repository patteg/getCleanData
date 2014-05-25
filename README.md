Description of how the run_analysis.R script works:

1. Download the dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Unzip the data files into a subfolder 'UCI HAR Dataset'

3. Run source('run_analysis.R) in R Studio

4. Script will create 2 files in the working folder:
     a. 'scrubbed_data_set.txt'  -> merged and scrubbed original data set
     b. 'tidy_data_set.txt' -> scrubbed and summarized data from merged data set

5. File can be analyzed by reloading back into R (read.table('./tidy_data_set.txt'))
