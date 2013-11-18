% results = testRegressor(testIn, params)
% 
% testRegressor uses a mapping that has been trained by trainRegressor to
% predict the one-dimensional outputs for the two-dimensional inputs
% testIn.
%
% 
function results = testRegressorTime(testIn, params)
	% Normalise input values
	ntime = normalise(testIn(:,1));
	nlat = normalise(testIn(:,2));
	nlong = normalise(testIn(:,3));
	%Calculate value at this point
	results = evalAllGaussTime(params, ntime, nlong, nlat);

end