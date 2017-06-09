This codebook accompanies the script run_analysis.R which processes data from
the UCI HAR dataset. The script extracts only the mean and standard deviation
measurements from the dataset, and returns means of these data for each activity
and subject.

The following variables are used in the processing.

Part 1 - Creating the combined dataset

traindata - the training dataset is loaded into this dataframe (original data)
testdata - the test dataset is loaded into this dataframe (original data)
alldata - the training and test data are merged into this dataset

Part 2 - Isolate only the mean and standard deviation data

features - contains the list of all feature (i.e. variable) names (original data)
meanstd - contains the positions of variable names (i.e. an integer) in 'features' which contain
          either the strings "mean" or "std" - this identifies the necessary data
           - obtained by using grep to search 'features'
meanstddata - dataframe containing only mean or standard deviation data (
              obtained by using meanstd to index alldata)

Part 3 - appropriately label the activities

trainlabels - contains the names of the training dataset labels (original data)
testlabels - contains the names of the test dataset labels (original data)
alllabels - combines the test and training labels
activitylabels - contains the descriptive list of activity names (original data)
activity - contains descriptive label of activity for all observations, obtained
by using sapply on 'alllabels' to assign the descriptive names listed in 'activitylabels'

Part 4 - label the variables (i.e. features)

retfeatures - contains the variable names only for mean and standard deviation data.
             Obtained by indexing 'features' with 'meanstd'.

Part 5 - create a tidy dataset containing means of each variable for each
         activity and subject

numfeatures - the length of retfeatures, i.e. the total number of variables
numactivities - the total number of activities
tidyactivitymean - a data frame of number of columns = numfeatures and number
                  of rows = numactivities. This holds all the calculated mean data
                  with one data point for each unique combination of activity and variable.
                  This dataframe is filled by using a for loop over columns and
                  using tapply to calculate means for each activity in each column.
tidydum - a dummy vector which temporarily contains the calculated means
          whilst looping through the meanstddata to calculate means for each activity
trainsubjects - contains a list giving the subject for each observation in the training
dataset (original data)
testsubjects - contains a list giving the subject for each observation in the test
dataset (original data)
allsubjects - a combined vector containing both training and test subjects
totalsubjects - the total number of unique subjects
tidysubjectmean- a data frame of number of columns = numfeatures and number
                  of rows = totalsubjects. This holds all the calculated mean data
                  with one data point for each unique combination of subject and variable.
                  This dataframe is filled by using a for loop over columns and
                  using tapply to calculate means for each subject in each column.
tidydum2 - a dummy vector which temporarily contains the calculated means
          whilst looping through the meanstddata to calculate means for each subject

combinedmeans - final dataset containing the means of each observation for each
                activity and subject. This dataset contains an additional column
                to facilitate splitting of the activity and subject data if so desired.
                This data is exported to tidytrackingdata.csv
