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
	% Array of time values
	timeGap = range(rental(:,2)/100);
	times = (minTime : timeGap : maxTime);
	% Central line prices at stations for a given time
	centralLineByTime = zeros(size(centralLine,1),1);
	for (i=1 : size(times,2))
		% Add this time to centralLineIn
		timeVec = ones(size(centralLine,1),1)*(times(1,i));
		centralLineIn = [timeVec,centralLine];
		allIn = [trainIn;centralLineIn];
		% allIn(size(allIn,1),:)
		allPreds = testRegressor(allIn, params);
		% Get only the central line values
		allPreds(size(trainIn,1)+1: size(allPreds,1), :);
		centralLineByTime(:,i) = allPreds(size(trainIn,1)+1: size(allPreds,1), :);
	end

	stationPredsOverTime = []
	for (station=1:size(centralLine,2))
		timeVec = times'
		size(times)
		stationVec = ones(size(times,2),1)*station;
		priceVec = centralLineByTime(i,:);
		size(timeVec)
		size(stationVec)
		size(priceVec)
		pause
		[stationPredsOverTime;[timeVec, stationVec, priceVec]];
	end
end