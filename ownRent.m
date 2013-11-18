function o = ownRent(trainIn, params)
	% Own location
	ownLocation = [51.4861229, -0.2089814999];
	trainIn = [trainIn;ownLocation];

	ownPred = testRegressor(trainIn, params);
	o = ownPred(size(ownPred,1));
end
