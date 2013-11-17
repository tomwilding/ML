clearvars *
load('rental.mat')
% Sample size
sampleSize = 10000;
rentalFiltered = filterOutliers(rental);
allIn = [rentalFiltered(:,2), rentalFiltered(:,3),rentalFiltered(:,4), rentalFiltered(:,1)];
allInByTime = sortrows(allIn,1);
numChunks = 2;
chunkSize = floor(size(allInByTime,1) / numChunks);
correctPreds = 0;
% Train regressor on each time chunk
for(s=1:numChunks)
	% Train using current chunk
	trainInTime = allInByTime(((s-1)*chunkSize) + 1 : s*chunkSize, :);
	params(s) = trainRegressorTime(trainInTime(:,(1:3)), trainInTime(:,4));
	% Get random sample from current chunk
	randomOrderTime = trainInTime(randperm(size(trainInTime,1)),:);
	if (sampleSize < size(trainInTime,1))
		% Ensure sample size is less than chunk size
		samples = randomOrderTime((1:sampleSize),:);
		% For random samples get prediction for both regressors 
		% Add to correct classifications
		allPredsRegressor = testRegressorTime(samples(:,(1:3)), params(s));
		% record the distance from the actual value for each pred
		distanceFromActual(:,s) = abs(allPredsRegressor - samples(:,4));
	end
end

% Find which regressor is closest to actual value
[val, bestIndex] = min(distanceFromActual');

% Iterate chunks to count the number of correct predictions
for(s=1:numChunks)
	% Get the nubmer of predictions for the regressor of this chunk
	bestIndex';
	predsForRegressor = find(bestIndex'==s);
	correctPreds = size(predsForRegressor,1);
	acc(s) = (correctPreds / sampleSize)
end