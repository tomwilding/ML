% clearvars *
% load('rental.mat')

% rentalFiltered = filterOutliers(rental);

% trainIn = [rentalFiltered(:,3) rentalFiltered(:,4)];
% trainOut = rentalFiltered(:,1);

% % Combine input
% combinedData = [trainOut, trainIn];
% % Re-order data randomly
% randomOrderData = combinedData(randperm(size(combinedData,1)),:);

% % Change the mod n to segment different proportions of data
% n = 4;
% testIndicies = mod(1:size(randomOrderData,1), n)==1;
% trainIndicies = ~testIndicies;

% clearvars testIn
% testIn(:,1) = randomOrderData(testIndicies,2);
% testIn(:,2) = randomOrderData(testIndicies,3);

% clearvars trainIn
% trainIn(:,1) = randomOrderData(trainIndicies,2);
% trainIn(:,2) = randomOrderData(trainIndicies,3);
% trainOut = randomOrderData(trainIndicies,1);

% % Train reg
% params = trainRegressor(trainIn, trainOut);

% Questions using the same trained regressor
% compareVals(trainIn, params)
% t = tubeValues(trainIn, params)
c = centralLineValues(trainIn,params);
% i = imperial(trainIn, params)
% u = upminster(trainIn, params)
% surfLondon(trainIn, params);
own = ownRent(trainIn, params)