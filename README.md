# Data Analysis, Modeling and Algorithms
# Author: Shaarang Buckal


## Background
Statistics aids human in revealing latent pattern in the data. We used K-means clustering to segregate TripAdvisor reviewers based on their reviews related to Sports and Religion events and trips.	

## Data Source
The dataset is fetched from TripAdvisor, for 249 high volume reviewers and their reviews in six categories. We will choose only two categories as mentioned above. 

## Data Transformation and Cleaning (Description)
The User_ID column was removed as it is simply noise for the model.
No other explicit data transformation was required.
We normalized all the features so that their respective data points are compatible with the clustering model and there is a common scale among all the features for comparison.
I normalized features by subtracting the minimum value of a feature from each of its respective data points and dividing the results by the margin of the corresponding feature
norm01 <- function(x) {return ((x - min(x)) / (max(x) - min(x)))} 

## Descriptive Data Analysis

