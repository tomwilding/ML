clearvars *
load('rental.mat')
rentalFiltered = filterOutliers(rental);
trainIn = [rentalFiltered(:,2), rentalFiltered(:,3), rentalFiltered(:,4)];
trainOut = rentalFiltered(:,1);

numFold = 4;
rmse = zeros(1,numFold);

% Combine input
combinedData = [trainOut, trainIn];
% Re-order data randomly
randomOrderData = combinedData(randperm(size(combinedData,1)),:);

% Randomly re-order data
for (i=1 : numFold)
	% Break into equal row size
	% Find test data by splitting according to mod
	clearvars testIn;
	testIndicies = mod(1:size(randomOrderData,1), numFold)==i-1;
	trainIndicies = ~testIndicies;
	% Test data
	testIn(:,1) = randomOrderData(testIndicies,2);
	testIn(:,2) = randomOrderData(testIndicies,3);
	testIn(:,3) = randomOrderData(testIndicies,4);
	testOut = randomOrderData(testIndicies,1);
	% Train data
	clearvars trainIn;
	trainIn(:,1) = randomOrderData(trainIndicies,2);
	trainIn(:,2) = randomOrderData(trainIndicies,3);
	trainIn(:,3) = randomOrderData(trainIndicies,4);
	trainOut = randomOrderData(trainIndicies,1);
	% Train and test the regressor on the data chunks
	params = trainRegressorTimeChunks(trainIn, trainOut);
	gaussEval = testRegressorTimeChunks(testIn, params);

	% For each chunk get RMSError
	% Break data in time chunks
    numChunks = 4;
    chunkSize = floor(size(testIn,1) / numChunks);

    % Get root mean sqaured error for each time chunk
	ntime = normalise(testIn(:,1));
    allIn = [ntime, testOut];
	testOutByTime = sortrows(allIn,1);
    for(j=1:numChunks)
    	testOutChunk = testOutByTime((i-1)*chunkSize+1: i*chunkSize, 2);
		chunkRmse(j) = rmserror(gaussEval(i), testOutChunk);
	end
	avgChunkRmse(i) = mean(chunkRmse)
end
overallRmse = nanmean(avgChunkRmse)
