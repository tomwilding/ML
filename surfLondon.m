function a = surfLondon(trainIn, params)
	% clearvars *
	load('rental.mat')

	% rentalFiltered = filterOutliers(rental);

	% trainIn = [rentalFiltered(:,3) rentalFiltered(:,4)];
	% trainOut = rentalFiltered(:,1);

	% % Combine input
	% combinedData = [trainOut, trainIn];
	% % Re-order data randomly
	% randomOrderData = combinedData(randperm(size(combinedData,1)),:);

	% % Change the mod n to segment different proportions of data
	% n = 4;
	% testIndicies = mod(1:size(randomOrderData,1), n)==1;
	% trainIndicies = ~testIndicies;

	% testIn(:,1) = randomOrderData(testIndicies,2);
	% testIn(:,2) = randomOrderData(testIndicies,3);

	% clearvars trainIn
	% trainIn(:,1) = randomOrderData(trainIndicies,2);
	% trainIn(:,2) = randomOrderData(trainIndicies,3);
	% trainOut = randomOrderData(trainIndicies,1);

	% % Train reg
	% params = trainRegressor(trainIn, trainOut);

	%test regressor over range of long and lat coordinates
	lat = trainIn(:,1);
	long = trainIn(:,2);
	longRangeStep = range(long) / 100;
	latRangeStep = range(lat) / 100;
	longRange = (min(long):longRangeStep:max(long));
	latRange = (min(lat):latRangeStep:max(lat));

	[X,Y] = meshgrid(latRange, longRange);
	% size(testIn)
	% gaussEval = testRegressor(testIn, params);
	% plot3(testIn(:,1),testIn(:,2),gaussEval, '.r');
	%
	% params.w = [1,1,1,1,1,1,1,1,1]
	% params.c = [[0:1/3:1]', [0:1/3:1]']
	% params.r = [ones(3,1), ones(3,1)]
	% params.b = 10

	XReshape = reshape(X, size(longRange,2)^2,1);
	YReshape = reshape(Y, size(latRange,2)^2,1);
	testIn = [XReshape,YReshape];

	gaussEval = testRegressor(testIn, params);
	gaussEvalReshape = reshape(gaussEval, size(longRange,2), size(latRange,2));

	surf(X,Y,gaussEvalReshape);
	title('Rental Prices at London Locations','FontSize',16)
	xlabel('Longitude [Deg]','FontSize',14);
	% xlim([-0.8,0.4]);
	% ylim([51.1,51.9]);
	ylabel('Latitude [Deg]','FontSize',14);
	zlabel('Price [£]','FontSize',14);

	hold on;
	colorbar
	tys = ones(size(tube.location,1))*2500;
	plot3(tube.location(:,1), tube.location(:,2), tys, 'or');

end