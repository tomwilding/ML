% results = testRegressor(testIn, params)
% 
% testRegressor uses a mapping that has been trained by trainRegressor to
% predict the one-dimensional outputs for the two-dimensional inputs
% testIn.
%
% 
function results = testRegressor(testIn, params)

	nlat = normalise(testIn(:,1));
	nlong = normalise(testIn(:,2));
	%Calculate value at this point
	results = evalAllGauss(params.w, params.b, params.c, params.r, nlat, nlong);

end