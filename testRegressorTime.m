% results = testRegressor(testIn, params)
% 
% testRegressor uses a mapping that has been trained by trainRegressor to
% predict the one-dimensional outputs for the two-dimensional inputs
% testIn.
%
% 
function results = testRegressorTime(testIn, params)

	ntime = normalise(testIn(:,1));
	nlong = normalise(testIn(:,2));
	nlat = normalise(testIn(:,3));
	%Calculate value at this point
	results = evalAllGaussTime(params.w, params.b, params.c, params.r, ntime, nlong, nlat);

end