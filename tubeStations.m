% clearvars *
load('rental.mat')

rentalFiltered = filterOutliers(rental);

% trainIn = [rentalFiltered(:,3) rentalFiltered(:,4)];
% trainOut = rentalFiltered(:,1);

% % Combine input
% combinedData = [trainOut, trainIn];
% % Re-order data randomly
% randomOrderData = combinedData(randperm(size(combinedData,1)),:);

% % Change the mod n to segment different proportions of data
% n = 4;
% clearvars testIn
% testIndicies = mod(1:size(randomOrderData,1), n)==1;
% trainIndicies = ~testIndicies;

% clearvars trainIn
% trainIn(:,1) = randomOrderData(trainIndicies,2);
% trainIn(:,2) = randomOrderData(trainIndicies,3);
% trainOut = randomOrderData(trainIndicies,1);

% % Train reg
% params = trainRegressor(trainIn, trainOut);
% params;
tubeIn = [normalise(tube.location(:,1)), normalise(tube.location(:,2))];
tubePreds = testRegressor(tubeIn, params);
argTube = mean(tubePreds);
sdTube = std(tubePreds);

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
centralLineIn = [uniqueTubeLatOnLine, uniqueTubeLongOnLine];
centralLinePreds = testRegressor(centralLineIn, params);
% centralLinePredictions = [uniqueTubeNamesOnLine, centralLinePreds];
bar(centralLinePreds);
title('Predicted Rental Price on the Central Line','FontSize',16)
xlabel('Station','FontSize',14);
ylabel('Price [£]','FontSize',14);
set(gca, 'XTickLabel', '', 'XTick', 1:numel(centralline));
hx = get(gca,'XLabel');
set(hx,'Units','data');
pos = get(hx, 'Position');
y = pos(2);
for i = 1:size(centralline,1)
	t(i) = text(i, y+20, centralline{i});
end
set(t,'Rotation', 90, 'HorizontalAlignment','left', 'Color', 'w');
grid on;