##Step 0 - Load relevant data and libraries.
  library(dplyr)

  #Import all the relevant data from the downloaded and unzipped file relative to the working directory.
  training_X_data <- read.table(file =  ".//UCI\ HAR\ Dataset//train//X_train.txt")
  training_y_data <- read.table(file =  ".//UCI\ HAR\ Dataset//train//y_train.txt")
  training_sub_data <- read.table(file =  ".//UCI\ HAR\ Dataset//train//subject_train.txt")
  test_X_data <- read.table(file =  ".//UCI\ HAR\ Dataset//test//X_test.txt")
  test_y_data <- read.table(file =  ".//UCI\ HAR\ Dataset//test//y_test.txt")
  test_sub_data <- read.table(file =  ".//UCI\ HAR\ Dataset//test//subject_test.txt")
  
  
  
##Step 1 - Join X_train, X_test, y_train, y_test, sub_train and sub_test into one dataset.

  #Join test & training data for X, y and sub to form one X, one y & one sub dataset.
  X <- rbind(training_X_data, test_X_data) #independent training & test variables
  y <- rbind(training_y_data, test_y_data) #predictor training & test variables
  s <- rbind(training_sub_data, test_sub_data) #subject training & test variables
  
  #Join these datasets such that s & y become columns appended to X
  main_dataset <- cbind(X, y, s)

  #Remove no-longer-revelant datasets from memory (they're confusing to look at in RStudio).
  rm(training_X_data, training_y_data, test_X_data, test_y_data, training_sub_data, test_sub_data, X, y, s)
  
  
  
##Step 2 - Extract only the measurements involving calculating std. dev or mean.
  
  #Import the meaning of each of the independent variables
  features <- read.table(file =  ".//UCI\ HAR\ Dataset//features.txt")
  
  #Using dplyr, extract rows where "std" or "mean" in measurement name
  stdmean_measurements <- filter(features, grepl("std", V2, fixed = TRUE) | grepl("mean", V2, fixed = TRUE)) 
  
  #Extract original indices corresponding to relevant (std or mean) entries in main_dataset. 
  main_dataset <- main_dataset[, c(562, 563, stdmean_measurements[,1])] #Manually concatenate index correspoding to predictor and subject.
  
  
  
##Step 3 - Replace activity numbers with descriptive phrases.
  
  #Import activity labels from text file.
  activity_labels <- read.table(file =  ".//UCI\ HAR\ Dataset//activity_labels.txt")
  
  #Using dplyr, create a new column containing activity_labels instead of numerical codes, remove the numerical code column and reorder.
  main_dataset <- mutate(main_dataset, activity = activity_labels[V1,2])
  main_dataset$V1 <- NULL #Remove the numerically encoded predictor variable (y)
  main_dataset <- select(main_dataset, activity, everything()) #Reorder the table such that activity is first column.
  
  

##Step 4 - Create descriptive variable names.
  
  #Extract relevant column names from features txt file and make them the column names.
  column_names <- c("activity", "subject", as.character(stdmean_measurements[,2])) 
  colnames(main_dataset) <- column_names
  
  

##Step 5 - Create summary dataset.
  
  #Group the data in main_dataset by subject and activity (in that order) and then calculate the mean of each subcategory.
  summary_dataset <- group_by(main_dataset, subject, activity) 
  summary_dataset <- summarise_all(summary_dataset, mean)
  
  #Finally output the clean summary dataset to the working directory/repo.
  write.table(summary_dataset, file = "summary_dataset.txt", row.names = FALSE, col.names = TRUE)
