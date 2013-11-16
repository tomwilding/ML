function pos = highestIncrease(trainIn, params)
	load('rental.mat')
	% Iterate through all values of lat and long for smallest time
	% and find difference between largest time
	times = trainIn(:,1);
	lats = trainIn(:,2);
	longs = trainIn(:,3);
	spaceGranularity = 100;
	timeGranularity = 100;
	% Granularity of positions
	latRangeStep = range(lats) / (spaceGranularity-1);
	longRangeStep = range(longs) / (spaceGranularity-1);

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
	% minTimeIn = [intialTime, XReshape, YReshape];
	% % Append trainIn to test data
	% allInMinTime = [minTimeIn;trainIn];
	% % Get predictions for all locations at the initial time point
	% allPreds = testRegressorTime(allInMinTime, params);
	% predsMinTime = allPreds(1:size(minTimeIn,1));

	% % Get predicted value of all poiints at the max time
	% maxTimeIn = [endTime, XReshape, YReshape];
	% % Append trainIn to test data
	% allInMaxTime = [maxTimeIn;trainIn];
	% % Get predictions for all locations at the initial time point
	% allPreds = testRegressorTime(allInMaxTime, params);
	% predsMaxTime = allPreds(1:size(maxTimeIn,1));

	% % Find greatest difference assume higher at end
	% priceDiffs = predsMaxTime - predsMinTime;
	% [highestPriceDiff, highestPriceIndex] = max(priceDiffs);
	% highestPriceDiff
	% pos = positions(highestPriceIndex, :);

	% Get preds at all time steps
	minTime = min(rental(:,2));
	maxTime = max(rental(:,2));
	timeRangeStep = (maxTime-minTime) / (timeGranularity-1);
	timeRange = (minTime:timeRangeStep:maxTime)';
	prevTimePreds = zeros(size(XReshape,1),1);
	increasePredsWithMinTime = [];
	for(ti=1:size(timeRange,1))
		% Get current time point
		time = timeRange(ti);
		% Creat time vec at this time
		timeVec = ones(size(latRange,2)^2,1)*time;
		timeIn = [timeVec, XReshape, YReshape];
		timeAllIn = [timeIn;trainIn];
		% Get time predicitons for all positions at current time
		timeAllPreds = testRegressorTime(timeAllIn, params);
		timePreds = timeAllPreds(1:size(timeIn,1));
		% Find the difference in the time step
		diffTimePreds = timePreds - prevTimePreds;
		% Only get increase by taking max with 0
		increasePredsWithMinTime = [increasePredsWithMinTime,max(diffTimePreds,0)];
		% Set previous predictions to current predictions
		prevTimePreds = timePreds;
	end
	% Find max increase by finding the maximal row sum 
	[highestPriceDiff, highestPriceIndex]  = max(sum(increasePredsWithMinTime(:,(2:size(increasePredsWithMinTime,2)))'));
	highestPriceDiff
	pos = positions(highestPriceIndex, :);
end