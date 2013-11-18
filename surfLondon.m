function a = surfLondon(trainIn, params)
	%test regressor over range of long and lat coordinates
	lat = trainIn(:,1);
	long = trainIn(:,2);
	longRangeStep = range(long) / 100;
	latRangeStep = range(lat) / 100;
	longRange = (min(long):longRangeStep:max(long));
	latRange = (min(lat):latRangeStep:max(lat));

	% Create mesh of finely spaced coordinates
	[X,Y] = meshgrid(latRange, longRange);
	% Reshape to pass to testRegressor	 
	XReshape = reshape(X, size(longRange,2)^2,1);
	YReshape = reshape(Y, size(latRange,2)^2,1);
	testIn = [XReshape,YReshape];

	gaussEval = testRegressor(testIn, params);
	% Reshape the predictions back to the required shape
	gaussEvalReshape = reshape(gaussEval, size(longRange,2), size(latRange,2));
	
	% Surf plot the predictions at the finely spaced coordinates 
	surf(X,Y,gaussEvalReshape);
	title('Rental Prices at London Locations','FontSize',16)
	xlabel('Longitude [Deg]','FontSize',14);
	% xlim([-0.8,0.4]);
	% ylim([51.1,51.9]);
	ylabel('Latitude [Deg]','FontSize',14);
	zlabel('Price [£]','FontSize',14);

	% Add tube coordinates for heat map plot
	% hold on;
	% colorbar
	% tys = ones(size(tube.location,1))*2500;
	% plot3(tube.location(:,1), tube.location(:,2), tys, 'or');

end