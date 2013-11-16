function params = trainRegressorTimeChunks(trainIn, trainOut)
	% Normalise
    time = normalise(trainIn(:,1));
    lat = normalise(trainIn(:,2));
    long = normalise(trainIn(:,3));

    % Break data in time chunks
    numChunks = 4;
    size(lat)
    chunkSize = floor(size(trainIn,1) / numChunks)
    pause

    % Order data by time before chunking
    allIn = [time, lat, long, trainOut];
	allInByTime = sortrows(allIn,1);
	allInByTime(:,(2:3))
	pause

	for (i=1 : numChunks)
		% Break into chunks of equals size
		allInChunk = allInByTime((i-1)*chunkSize+1: i*chunkSize, :);
		params(i) = trainRegressor(allInChunk(:,(2:3)), allInChunk(:,4))
	end

end