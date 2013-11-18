% QBd - i
load('rental.mat')
if (~(exist('paramsPos') && exist('trainInPos')))
	clearvars *
	load('rental.mat')
	rentalFiltered = filterOutliers(rental);

	trainInPos = [rentalFiltered(:,3) rentalFiltered(:,4)];
	trainOut = rentalFiltered(:,1);

	% Combine input
	combinedData = [trainOut, trainInPos];
	% Re-order data randomly
	randomOrderData = combinedData(randperm(size(combinedData,1)),:);

	% Only use one iteration of the validation
	n = 4;
	testIndicies = mod(1:size(randomOrderData,1), n)==1;
	trainIndicies = ~testIndicies;

	clearvars testIn
	testIn(:,1) = randomOrderData(testIndicies,2);
	testIn(:,2) = randomOrderData(testIndicies,3);

	clearvars trainInPos
	trainInPos(:,1) = randomOrderData(trainIndicies,2);
	trainInPos(:,2) = randomOrderData(trainIndicies,3);
	trainOut = randomOrderData(trainIndicies,1);

	% Train reg
	paramsPos = trainRegressor(trainInPos, trainOut);
end
% QBd - i using the same trained regressor above
% (See crossValidation for cross validation)
%%%% UNCOMMENT TO RUN REQUIRED QUESTION! %%%%

% QBd) - Tube mean and standard deviation
% tubeVals = tubeValues(trainInPos, paramsPos)

% QBe) - Bar chart of central line predictions
% centralVals = centralLineValues(trainInPos,paramsPos);

% QBf) - Prediction at Imperial
% imperialVal = imperial(trainInPos, paramsPos)

% QBg) - Prediction at Upminster
% upminsterVal = upminster(trainInPos, paramsPos)

% QBh) - Mesh grid surf plot
surfLondon(trainInPos, paramsPos);

% QBi) - My own rent prediction
% ownVal = ownRent(trainInPos, paramsPos)