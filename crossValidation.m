function avgmse = crossValidation(trainIn, trainOut, n)

	rmse = zeros(1,n);

	% Combine input
	combinedData = [trainOut, trainIn];
	% Re-order data randomly
	randomOrderData = combinedData(randperm(size(combinedData,1)),:);

	% Randomly re-order data
	for (i=1 : n)
		% Break into equal row size
		% Find test data by splitting according to mod
		clearvars testIn
		trainIndicies = mod(1:size(randomOrderData,1), n)==i-1;
		testIndicies = ~trainIndicies;
		testIn(:,1) = randomOrderData(testIndicies,2);
		testIn(:,2) = randomOrderData(testIndicies,3);
		testOut = randomOrderData(testIndicies,1);

		clearvars trainIn
		trainIn(:,1) = randomOrderData(trainIndicies,2);
		trainIn(:,2) = randomOrderData(trainIndicies,3);
		trainOut = randomOrderData(trainIndicies,1);

		params = trainRegressor(trainIn, trainOut);
		gaussEval = testRegressor(testIn, params);

		% size(trainIn)
		% size(testIn)
		% pause
		% plot3(testIn(:,1),testIn(:,2),gaussEval, '.r');

		rmse(i) = rmserror(gaussEval, testOut);
		avgmse = mean(rmse);
	end

end