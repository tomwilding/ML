function results = testRegressorTimeChunks(testIn, params)

	ntime = normalise(testIn(:,1));
	nlat = normalise(testIn(:,2));
	nlong = normalise(testIn(:,3));
	%Calculate value at this point
	results = evalAllGaussTimeChunks(params, ntime, nlong, nlat);

end