function centralLineByTime = centralLineOverTime(trainIn, params)
	load('rental.mat')

	centralline = {
		'Ealing Broadway',
		'North Acton',
		'West Acton',
		'East Acton',
		'White City',
		'Shepherd''s Bush',
		'Holland Park',
		'Notting Hill Gate',
		'Queensway',
		'Lancaster Gate',
		'Marble Arch',
		'Bond Street',
		'Oxford Circus',
		'Tottenham Court Road',
		'Holborn',
		'Chancery Lane',
		'St.Paul''s',
		'Bank',
		'Liverpool Street',
		'Bethnal Green',
		'Mile End',
		'Stratford'
	};

	% Rem Dups
	[uniqueTubeNames, uniqueTubeIndicies] = unique(tube.station);
	uniqueTubeNamesOnLine = [];
	uniqueTubeLatOnLine = [];
	uniqueTubeLongOnLine = [];
	for (i=1:size(uniqueTubeNames))
		if (ismember(uniqueTubeNames(i),centralline))
			uniqueTubeNamesOnLine = [uniqueTubeNamesOnLine;tube.station(uniqueTubeIndicies(i))];
			uniqueTubeLatOnLine = [uniqueTubeLatOnLine;tube.location(uniqueTubeIndicies(i),1)];
			uniqueTubeLongOnLine = [uniqueTubeLongOnLine;tube.location(uniqueTubeIndicies(i),2)];
		end
	end
	centralLine = [uniqueTubeLatOnLine, uniqueTubeLongOnLine];
	% Add times to evaluate reressor
	minTime = min(rental(:,2));
	maxTime = max(rental(:,2));
	% Num months
	numMonths = months(minTime, maxTime);
	% Array of time values
	timeGap = range(rental(:,2))/numMonths;
	times = (minTime : timeGap : maxTime);
	% Central line prices at all stations for a given time
	allIn = trainIn;
	for (i=1 : size(times,2))
		% Add this time period to centralLineIn values
		timeVec = ones(size(centralLine,1),1)*(times(1,i));
		% Append this time vec to central line lat long inputs
		% centralLine
		% pause
		centralLineIn = [timeVec,centralLine];
		% centralLine
		% pause
		% pause
		allIn = [allIn;centralLineIn];
		% allIn
		% pause
		% allIn(size(allIn,1),:)
	end
	% Test on test data with all train data
	allPreds = testRegressor(allIn, params);
	% Get only the central line values at the end
	predsForTime = allPreds(size(trainIn,1)+1: size(allPreds,1), :);
	predsForTime(44:66)
	pause
	pause
	% size(predsForTime)
	% pause
	centralLineByTime = [];
	size(centralLine,1)
	for (station=1:size(centralLine,1))
		% size(times,2)
		% Vector of the current station which is the length of time
		stationVec = ones(size(times,2),1)*station;
		% size(stationVec)
		% Prices for the current station over all time chunks 
		% pause
		priceVec = predsForTime((station-1)*size(times,2)+1:station*(size(times,2)));
		% size(priceVec)
		% priceVec
		% pause
		% append current time, station number and price preds
		centralLineByTime = [centralLineByTime;[times', stationVec, priceVec]]
	end
	plot3(centralLineByTime(:,1), centralLineByTime(:,2), centralLineByTime(:,3),'.')
end