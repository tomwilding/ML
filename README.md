Machine Learning Coursework Questions and associated Files

QA) MLE using gradient descent
pricesOverTime.m
(uses MLEGradDescAll.m, LLgradAll.m, LLAll.m)

QB)
a) 3D Plot of rental prices to location
pricesOverLocation.m 

b) Train and test regressor 
trainRegressor.m, testRegressor.m

c) RMSE using cross validation
crossValidation.m

d) - i)
For the same resuts as the report load('paramsPos.mat'); load('trainInPos.mat')
quarterTrainPos.m %%%%UNCOMMENT AS REQUIRED%%%%

QC)
a) Account for passage of time
Gaussians that take space and time (option 2):
crossValidationTime.m
(uses trainRegressorTime.m, testRegressorTime.m)

Chunk data in time (option 3):
crossValidationTimeChunks.m
(uses trainRegressorTimeChunks.m, testRegressorTimeChunks.m)

For the same resuts as the report load('paramsTime.mat'); load('trainInTime.mat')
Central line price changes over time:
quarterTrainTime.m

b) Highest increase in rental price
quarterTrainTime.m %%%%UNCOMMENT AS REQUIRED%%%%

c) Bayesian classifier
bayClassifier.m