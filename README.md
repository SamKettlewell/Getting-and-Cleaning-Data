# Getting-and-Cleaning-Data - Coursera Peer Assessed Project
This repository contains the project files for Coursera Getting and Cleaning Data Week 4 peer assessment. Begin by cloning the repository,downloading and unzipping the dataset into your local repo. The dataset can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

## Dataset Explanation
The dataset contains 561 unique measurements from the sensors of a Samsung Galaxy S II taken from 30 different people when they were doing one of six activities: walking, walking_upstairs, walking_downstairs, sitting, standing and laying.

## The ```run_analysis.R``` script.
Once you have done this, execute the ```run_analysis.R``` script. This generates both 
-a tidy copy of the dataset having merged the training and testing examples and selected only measurements involving mean or standard deviation measurements, and,
-a tidy summary dataset containing the average (mean) values of all mean and standard deviation measurements for each activity for each subject.
The script then outputs the summary dataset as a text file.

In particular, the ```run_analysis.R``` script
1. Merges the training and test datasets into one dataset.
2. Extracts only the measurements (dependent variables) corresponding to measurements of mean and standard deviation.
3. Labels the activity (predictor variable) with a suitable descriptive name rather than a numerical code.
4. Labels the columns of the dataset with descriptive variable names.
5. Creates a second summary dataset containing the average (mean) values of all mean and standard deviation measurements for each activity for each subject and produces the ```summary_dataset.txt```
