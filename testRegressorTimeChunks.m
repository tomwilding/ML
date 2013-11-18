function results = testRegressorTimeChunks(testIn, params)
	% Normalise input values
	ntime = normalise(testIn(:,1));
	nlat = normalise(testIn(:,2));
	nlong = normalise(testIn(:,3));

    % Break data in time chunks
    numChunks = 4;
    chunkSize = floor(size(testIn,1) / numChunks);

    % Order data by time before chunking
    allIn = [ntime, nlat, nlong];
	allInByTime = sortrows(allIn,1);
	allInByTime(:,(2:3));

	for (i=1 : numChunks)
		% Break into chunks of equals size
		allInChunk = allInByTime((i-1)*chunkSize+1: i*chunkSize, :);
		results(:,i) = evalAllGauss(params(i), allInChunk(:,(2)), allInChunk(:,(3)));
	end
end