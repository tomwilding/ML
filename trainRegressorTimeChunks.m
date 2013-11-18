function params = trainRegressorTimeChunks(trainIn, trainOut)
	% Normalise
    ntime = normalise(trainIn(:,1));
    nlat = normalise(trainIn(:,2));
    nlong = normalise(trainIn(:,3));

    % Break data in time chunks
    numChunks = 4;
    chunkSize = floor(size(trainIn,1) / numChunks);

    % Order data by time before chunking
    allIn = [ntime, nlat, nlong, trainOut];
	allInByTime = sortrows(allIn,1);
	allInByTime(:,(2:3));

	for (i=1 : numChunks)
		% Break into chunks of equals size
	   allInChunk = allInByTime((i-1)*chunkSize+1: i*chunkSize, :);
	   params(i) = trainRegressor(allInChunk(:,(2:3)), allInChunk(:,4));
    end

end