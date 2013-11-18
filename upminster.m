function u = upminster(trainIn, params)
	load('rental.mat')
	% Pass all data train on plus upminster
	trainIn = [trainIn;tube.location(264,:)];
	% Get all predictions
	upminsterPred = testRegressor(trainIn, params);
	% Get prediction at Upminster station 
	u = upminsterPred(size(upminsterPred,1));
end
