# This README file contains a description of run_analysis.R to illuminate future users of this code.

run_analysis.R performs each part of the data tidying specified in the
"Getting and Cleaning Data" Week4 assignment in turn.

## Part 1 - Creating the combined dataset

This part of the code loads the training and test datasets into separate dataframes and then uses merge to combine them into a single dataframe.

* traindata - the training dataset is loaded into this dataframe (original data)
* testdata - the test dataset is loaded into this dataframe (original data)
* alldata - the training and test data are merged into this dataset

## Part 2 - Isolate only the mean and standard deviation data

This part loads the feature (i.e. variable) names provided and searches them for strings containing mean or std using the grep function. It then returns a list of all the columns in the dataframe which contain either mean or standard deviation data.

* features - contains the list of all feature (i.e. variable) names (original data)
* meanstd - contains the positions of variable names (i.e. an integer) in 'features' which contain either the strings "mean" or "std" - this identifies the necessary data
           - obtained by using grep to search 'features'
* meanstddata - dataframe containing only mean or standard deviation data (obtained by using meanstd to index alldata)

## Part 3 - appropriately label the activities

This part loads the activity labels for the training and test datasets and combines them into a single vector. It also loads a table which provides descriptive names of each activity. An sapply function is then used to convert all the numerical labels to descriptive names.

* trainlabels - contains the names of the training dataset labels (original data)
* testlabels - contains the names of the test dataset labels (original data)
* alllabels - combines the test and training labels
* activitylabels - contains the descriptive list of activity names (original data)
* activity - contains descriptive label of activity for all observations, obtained
by using sapply on 'alllabels' to assign the descriptive names listed in 'activitylabels'

## Part 4 - label the variables (i.e. features)

The list of columns in the data frame containing mean or std data (generated in Part 2) is used to obtain the corresponding variable names from 'features'. Several calls to the sub function are used to make the variable names more descriptive (based on the details provided in features_info.txt).

* retfeatures - contains the variable names only for mean and standard deviation data.
             Obtained by indexing 'features' with 'meanstd'.

## Part 5 - create a tidy dataset containing means of each variable for each activity and subject

This part of the code first creates a dataframe of appropriate size to contain
the mean data for each activity (i.e. number of activities = 6 rows and number of variables = 66 columns). A for loop is then used to call tapply on each variable column in the combined dataset and calculate a mean for each activity. A similar approach is used to generate a dataframe containing the means for each subject. The two datasets each have a column appended to specify whether the data is an activity or subject mean. The datasets are then combined into a single data frame which is exported to "tidytrackingdata.csv".

* trainsubjects - contains a list giving the subject for each observation in the training dataset (original data)
* testsubjects - contains a list giving the subject for each observation in the test
dataset (original data)
* allsubjects - a combined vector containing both training and test subjects
* sorted - the result of sorting the rows in meanstddata by activity and subject
* splitted - the result of splitting sorted by activity and suject, yielding a list of 180 data frames
* meancalc - a data.frame of appropriate dimension to fill with the mean data
* meanlabels - the appropriate labels of activity and subject for each row of meancalc
* tidydata - combining meancalc with two columns containing activity and subject labels

 This data is exported to tidytrackingdata.csv
