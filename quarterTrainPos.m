% QBd - i
clearvars *
load('rental.mat')

rentalFiltered = filterOutliers(rental);

trainIn = [rentalFiltered(:,3) rentalFiltered(:,4)];
trainOut = rentalFiltered(:,1);

% Combine input
combinedData = [trainOut, trainIn];
% Re-order data randomly
randomOrderData = combinedData(randperm(size(combinedData,1)),:);

% Only use one iteration of the validation
n = 4;
testIndicies = mod(1:size(randomOrderData,1), n)==1;
trainIndicies = ~testIndicies;

clearvars testIn
testIn(:,1) = randomOrderData(testIndicies,2);
testIn(:,2) = randomOrderData(testIndicies,3);

clearvars trainIn
trainIn(:,1) = randomOrderData(trainIndicies,2);
trainIn(:,2) = randomOrderData(trainIndicies,3);
trainOut = randomOrderData(trainIndicies,1);

% Train reg
params = trainRegressor(trainIn, trainOut);

% QBd - i using the same trained regressor above
% (See crossValidation for cross validation)
%%%% UNCOMMENT TO RUN REQUIRED QUESTION! %%%%

% QBd) - Tube mean and standard deviation
t = tubeValues(trainIn, params)

% QBe) - Bar chart of central line predictions
% c = centralLineValues(trainIn,params);

% QBf) - Prediction at Imperial
% i = imperial(trainIn, params)

% QBg) - Prediction at Upminster
% u = upminster(trainIn, params)

% QBh) - Mesh grid surf plot
% surfLondon(trainIn, params);

% QBi) - My own rent prediction
% own = ownRent(trainIn, params)