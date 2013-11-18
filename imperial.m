function i = imperial(trainIn, params)
	% Imperial location
	imperialIn = [51.499019,0.176256];
	% Add trainIn data to imperial to get predictions
	trainIn = [trainIn;imperialIn];
	imperialPred = testRegressor(trainIn, params);
	% Get only the prediction at Imperial
	i = imperialPred(size(imperialPred,1));
end