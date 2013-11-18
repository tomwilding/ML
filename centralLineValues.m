function clv = centralLineValues(trainIn, params)
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

	% Remove duplicate tube names
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
	% Order stations by central line order
	orderedStations = sortCentralLine(uniqueTubeNamesOnLine, uniqueTubeLatOnLine, uniqueTubeLongOnLine, centralLineNames);
	centralLineIn = [orderedStations.lats,orderedStations.longs];

	% Test regressor using all values trained
	allIn = [trainIn;centralLineIn];
	allPreds = testRegressor(allIn, params);
	% Get only the central line values
	centralLinePreds = allPreds(size(trainIn,1)+1: size(allPreds,1), :);

	bar(centralLinePreds);
	title('Predicted Rental Price on the Central Line','FontSize',16)
	xlabel('Station','FontSize',14);
	ylabel('Price [£]','FontSize',14);
	hix = get(gca,'XLabel');
	set(gca, 'XTickLabel', '', 'XTick', 1:numel(centralLineNames));
	set(hix,'Units','data');
	position = get(hix, 'Position');
	y = position(2);
	for i = 1:size(centralLineNames,1)
		t(i) = text(i, y+100, centralLineNames{i});
	end
	set(t,'Rotation', 90, 'HorizontalAlignment','left', 'Color', 'w');
	grid on;
	axis tight;
	clv = centralLinePreds;

end