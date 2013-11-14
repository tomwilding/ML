function i = imperial(trainIn, params)
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
% clearvars testIn
% testIndicies = mod(1:size(randomOrderData,1), n)==i-1;
% trainIndicies = ~testIndicies;

% clearvars trainIn
% trainIn(:,1) = randomOrderData(trainIndicies,2);
% trainIn(:,2) = randomOrderData(trainIndicies,3);
% trainOut = randomOrderData(trainIndicies,1);

% % Train reg
% params = trainRegressor(trainIn, trainOut);
	imperialIn = [51.499019,0.176256];
	trainIn(size(trainIn,1)+1,1) = imperialIn(1,1);
	trainIn(size(trainIn,1),2) = imperialIn(1,2);
	imperialPred = testRegressor(trainIn, params);
	i = imperialPred(size(imperialPred,1));
end