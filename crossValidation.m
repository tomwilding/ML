clearvars *
load('rental.mat');
rentalFiltered = filterOutliers(rental);
trainIn = [rentalFiltered(:,3),rentalFiltered(:,4)];
trainOut = rentalFiltered(:,1);

nfold = 4;
rmse = zeros(1,nfold);

% Combine input
combinedData = [trainOut, trainIn];
% Re-order data randomly
randomOrderData = combinedData(randperm(size(combinedData,1)),:);

% Randomly re-order data
for (i=1 : nfold)
	% Break into equal row size
	% Find test data by splitting according to mod
	clearvars testIn
	testIndicies = mod(1:size(randomOrderData,1), nfold)==i-1;
	trainIndicies = ~testIndicies;
	testIn(:,1) = randomOrderData(testIndicies,2);
	testIn(:,2) = randomOrderData(testIndicies,3);
	testOut = randomOrderData(testIndicies,1);

	clearvars trainIn
	trainIn(:,1) = randomOrderData(trainIndicies,2);
	trainIn(:,2) = randomOrderData(trainIndicies,3);
	trainOut = randomOrderData(trainIndicies,1);
	% size(trainIn)
	% size(testIn)
	% pause
	params = trainRegressor(trainIn, trainOut);
	gaussEval = testRegressor(testIn, params);
	% plot3(testIn(:,1),testIn(:,2),gaussEval, '.r');

	foldRmse(i) = rmserror(gaussEval, testOut)
end
avgmse = mean(foldRmse)