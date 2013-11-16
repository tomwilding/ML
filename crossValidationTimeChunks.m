function avgmse = crossValidationTimeChunks(trainIn, trainOut, n)

	rmse = zeros(1,n);

	% Combine input
	combinedData = [trainOut, trainIn];
	% Re-order data randomly
	randomOrderData = combinedData(randperm(size(combinedData,1)),:);

	% Randomly re-order data
	for (i=1 : n)
		% Break into equal row size
		% Find test data by splitting according to mod
		clearvars testIn;
		% TEST on 1/4 train on 3/4 (Split to 3/16 when chunking by time)
		testIndicies = mod(1:size(randomOrderData,1), n)==i-1;
		trainIndicies = ~testIndicies;
		testIn(:,1) = randomOrderData(testIndicies,2);
		testIn(:,2) = randomOrderData(testIndicies,3);
		testIn(:,3) = randomOrderData(testIndicies,4);
		testOut = randomOrderData(testIndicies,1);

		clearvars trainIn;
		trainIn(:,1) = randomOrderData(trainIndicies,2);
		trainIn(:,2) = randomOrderData(trainIndicies,3);
		trainIn(:,3) = randomOrderData(trainIndicies,4);
		trainOut = randomOrderData(trainIndicies,1);
		% size(trainIn)
		% size(testIn)
		% pause
		params = trainRegressorTimeChunks(trainIn, trainOut);
		for(i=1:size(params,2))
			params(1).w
		end

		gaussEval = testRegressorTimeChunks(testIn, params);

		% plot3(testIn(:,2),testIn(:,3),gaussEval, '.r');

		rmse(i) = rmserror(gaussEval, testOut);
		avgmse = mean(rmse);
	end

end