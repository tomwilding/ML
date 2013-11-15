function pos = highestIncrease(trainIn, params)
	load('rental.mat')
	% Iterate through all values of lat and long for smallest time
	% and find difference between largest time
	times = trainIn(:,1);
	lats = trainIn(:,2);
	longs = trainIn(:,3);
	% Granularity of positions
	latRangeStep = range(lats) / 100;
	longRangeStep = range(longs) / 100;

	latRange = (min(lats):latRangeStep:max(lats));
	longRange = (min(longs):longRangeStep:max(longs));

	% min and max times
	minTime = min(rental(:,2));
	maxTime = max(rental(:,2));
	intialTime = ones(size(latRange,2)^2,1)*minTime;
	endTime = ones(size(latRange,2)^2,1)*maxTime;

	[X,Y] = meshgrid(latRange, longRange);

	XReshape = reshape(X, size(latRange,2)^2,1);
	YReshape = reshape(Y, size(longRange,2)^2,1);
	positions = [XReshape, YReshape];

	% Get predicted value of all poiints at the min time
	minTimeIn = [intialTime, XReshape, YReshape];
	% Append trainIn to test data
	allInMinTime = [minTimeIn;trainIn];
	% Get predictions for all locations at the initial time point
	allPreds = testRegressorTime(allInMinTime, params);
	predsMinTime = allPreds(1:size(minTimeIn,1));

	% Get predicted value of all poiints at the max time
	maxTimeIn = [endTime, XReshape, YReshape];
	% Append trainIn to test data
	allInMaxTime = [maxTimeIn;trainIn];
	% Get predictions for all locations at the initial time point
	allPreds = testRegressorTime(allInMaxTime, params);
	predsMaxTime = allPreds(1:size(maxTimeIn,1));

	% Find greatest difference assume higher at end
	priceDiffs = predsMaxTime - predsMinTime;
	[highestPriceDiff, highestPriceIndex] = max(priceDiffs);
	pos = positions(highestPriceIndex);
end