function tvs = tubeValues(trainIn, params)
	load('rental.mat')
	allIn = [trainIn;tube.location];

	allPreds = testRegressor(allIn, params);
	% Get just the predicted tube values
	tubePreds = allPreds(size(trainIn,1)+1: size(allPreds,1), :);
	tvs.avgTube = mean(tubePreds);
	tvs.sdTube = std(tubePreds);
end