clearvars *
load('rental.mat')

rentalFiltered = filterOutliers(rental);

trainIn = [rentalFiltered(:,2),rentalFiltered(:,3),rentalFiltered(:,4)];
trainOut = rentalFiltered(:,1);

% Combine input
combinedData = [trainOut, trainIn];
% Re-order data randomly
randomOrderData = combinedData(randperm(size(combinedData,1)),:);

% Only use one iteration of the validation
n = 4;
testIndicies = mod(1:size(randomOrderData,1), n)==1;
trainIndicies = ~testIndicies;

clearvars testIn;
testIn(:,1) = randomOrderData(testIndicies,2);
testIn(:,2) = randomOrderData(testIndicies,3);
testIn(:,3) = randomOrderData(testIndicies,4);
testOut = randomOrderData(testIndicies,1);

clearvars trainIn;
trainIn(:,1) = randomOrderData(trainIndicies,2);
trainIn(:,2) = randomOrderData(trainIndicies,3);
trainIn(:,3) = randomOrderData(trainIndicies,4);
trainOut = randomOrderData(trainIndicies,1);

% Train reg
params = trainRegressorTime(trainIn, trainOut);

% QC using the same trained regressor above
% (See crossValidation for cross validation)
%%%% UNCOMMENT TO RUN REQUIRED QUESTION! %%%%
% WCa) - Central Line over time
centralLineOverTime(trainIn, params);
% WCb) - Highest price change
% highestPriceChange = highestIncrease(trainIn, params)