# Coursera-Getting-and-Cleaning-Data-Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the necessary set of data, provided that it does not already exist within the user's working directory
2. Load the activity and feature information
3. Loads both the training and test datasets
4. Ensures only those columns that are kept are that which reflect a mean or standard deviation
5. Loads the activity and subject data for each dataset
6. Merges those columns with the dataset
6. Merges the two datasets themselves
7. Converts the `activity` and `subject` columns into factors, making them into pairs
8. Creates a tidy dataset that consists of the mean value of each
   variable for each pair

The end result is shown in the file `tidy.txt`.
