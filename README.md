This README file contains a description of run_analysis.R to illuminate
future users of this code.

run_analysis.R performs each part of the data tidying requested in the
"Getting and Cleaning Data" Week4 assignment in turn.

Part 1 - Creating the combined dataset

This part of the code loads the training and test datasets into separate
dataframes and then uses merge to combine them into a single dataframe

Part 2 - Isolate only the mean and standard deviation data

This part loads the feature (i.e. variable) names provided and searches
them for strings containing mean or std using the grep function. It then returns
a list of all the columns in the dataframe which contain either mean or
standard deviation data.

Part 3 - appropriately label the activities

This part loads the activity labels for the training and test datasets and
combines them into a single vector. It also loads a table which provides descriptive
names of each activity. An sapply function is then used to convert all the numerical
labels to descriptive names.

Part 4 - label the variables (i.e. features)

The list of columns in the data frame containing mean or std data (generated
  in Part 2) is used to obtain the corresponding variable names from 'features'
  A large number of calls to the sub function are used to make the variable names
  more descriptive (based on the details provided in features_info.txt).


Part 5 - create a tidy dataset containing means of each variable for each
         activity and subject

This part of the code first creates a dataframe of appropriate size to contain
the mean data for each activity (i.e. number of activities = 6 rows and number
  of variables = 66 columns). A for loop is then used to call tapply on each
  variable column in the combined dataset and calculate a mean for each activity.
  A similar approach is used to generate a dataframe containing the means for
  each subject. The two datasets each have a column appended to specify whether
  the data is an activity or subject mean. The datasets are then combined into
   a single data frame which is exported to "tidytrackingdata.csv".
