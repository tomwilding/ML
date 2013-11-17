function centralLineOverTime(trainIn, params)
	load('rental.mat')

	centralLineNames = {
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

	% Remove duplicate tube stations
	[uniqueTubeNames, uniqueTubeIndicies] = unique(tube.station);
	uniqueTubeNamesOnLine = [];
	uniqueTubeLatOnLine = [];
	uniqueTubeLongOnLine = [];
	for (i=1:size(uniqueTubeNames))
		if (ismember(uniqueTubeNames(i),centralLineNames))
			uniqueTubeNamesOnLine = [uniqueTubeNamesOnLine;tube.station(uniqueTubeIndicies(i))];
			uniqueTubeLatOnLine = [uniqueTubeLatOnLine;tube.location(uniqueTubeIndicies(i),1)];
			uniqueTubeLongOnLine = [uniqueTubeLongOnLine;tube.location(uniqueTubeIndicies(i),2)];
		end
	end
	
	orderedStations = sortCentralLine(uniqueTubeNamesOnLine, uniqueTubeLatOnLine, uniqueTubeLongOnLine, centralLineNames);

	centralLineSorted = [orderedStations.lats,orderedStations.longs];

	% Add times to evaluate reressor
	minTime = min(rental(:,2));
	maxTime = max(rental(:,2));
	% Num months
	numMonths = months(minTime, maxTime);
	% Start time
	startDateAsVec = datevec(minTime);
	endDateAsVec = datevec(maxTime);


	startTime = datenum([startDateAsVec(1) startDateAsVec(2) 0 0 0 0]);
	endTime = datenum([endDateAsVec(1) endDateAsVec(2) 0 0 0 0]);

	% Array of time values
	timeGap = range(rental(:,2))/(numMonths-1);
	times = (startTime : timeGap : endTime)';

	% Central line prices at stations for a given time
	allIn = trainIn;
	for (i=1 : size(centralLineSorted,1))
		% vector of one station coord
		stationVec = ones(size(times,1),1)*centralLineSorted(i,:);
		timeVec = times;
		centralLineIn = [timeVec,stationVec];
		% Combine input times and stations
		allIn = [allIn;centralLineIn];
	end
	% Predictions by stations at all times
	allPreds = testRegressorTime(allIn, params);
	% Get only the central line values
	predsForTime = allPreds(size(trainIn,1)+1: size(allPreds,1), :);
	% predsForTime

	styles = {
		'bo-';'ko-';'ro-';'yo-';'go-';'co-';'mo-'; ...
		'bs-';'ks-';'rs-';'ys-';'gs-';'cs-';'ms-'; ...
		'b*-';'k*-';'r*-';'y*-';'g*-';'c*-';'m*-';'bv-' ...
	};
	for (station=1:size(centralLineSorted,1))
		stationVec = ones(size(times,1),1)*station;
		priceVec = predsForTime((station-1)*size(times,1)+1: station*size(times,1));
		plot(times, priceVec, styles{station})
		legendInfo{station} = orderedStations.names{station};
		hold on;
		% centralLineByTime = [centralLineByTime;[times, stationVec, priceVec]];
	end
	% plot3(centralLineByTime(:,1), centralLineByTime(:,2), centralLineByTime(:,3))
	% surf([1:size(centralLineSorted,1)]', times, reshape(predsForTime, size(times,1), size(centralLineSorted,1)))
	% shading interp;
	title('Central Line Station Prices Over Time','FontSize',16)
	xlabel('Time','FontSize',14);
	ylabel('Price [£]','FontSize',14);
	% zlabel('Price [£]','FontSize',14);
	datetick('x', 12);
	legend(legendInfo, 'Location','NorthEastOutside');
	grid on;
	hold off;
end